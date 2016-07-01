//
//  JHContactsViewController.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHContactsViewController.h"
#import "JHContactsTableViewCell.h"
#import "JHContactModel.h"
#import "JHChatViewController.h"

@interface JHContactsViewController ()<UITableViewDataSource,UITableViewDelegate,XMPPRosterDelegate>
@property(nonatomic,strong)UITableView *tableView;
// 查询结果控制器
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation JHContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupView];
}

-(void)setupView{
    [self.view addSubview:self.tableView];
    // 添加按钮
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClick)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // 成为花名册模块的代理
    [[JHXMPPManager sharedInstance].xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

#pragma mark - 自定义方法
-(void)addButtonClick{
    // 添加的好友jid
    XMPPJID *aJID = [XMPPJID jidWithUser:@"erxiao" domain:jh_XMPP_Domian resource:nil];
    
    // 添加好友
    [[JHXMPPManager sharedInstance].xmppRoster addUser:aJID withNickname:@"二笑"];
}


#pragma mark - tableview 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 取出分组
    id<NSFetchedResultsSectionInfo> aSection = self.fetchedResultsController.sections[section];
    return aSection.numberOfObjects;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHContactsTableViewCell *cell = [JHContactsTableViewCell settingCellWithTableView:tableView style:UITableViewCellStyleDefault];
    
    // 取出联系人数据
    XMPPUserCoreDataStorageObject *aContacts = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // 账户名
//    UILabel *acountLb = [cell viewWithTag:101];
//    acountLb.text = aContacts.jidStr;
    JHContactModel *contactModel = [[JHContactModel alloc] init];
    contactModel.name = aContacts.jidStr;
    cell.contactModel = contactModel;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 当前选中的联系人
    XMPPUserCoreDataStorageObject *aContacts = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // 删除好友
    [[JHXMPPManager sharedInstance].xmppRoster removeUser:aContacts.jid];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.fetchedResultsController.sectionIndexTitles[section];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JHChatViewController *chatVC = [[JHChatViewController alloc] init];
    // 取出数据
    XMPPUserCoreDataStorageObject *aContacts = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    chatVC.jid = aContacts.jid; // 该jid不包含Resource字段
    chatVC.jid = aContacts.primaryResource.jid;
    
    [self.navigationController pushViewController:chatVC animated:YES];
     
}

#pragma mark - XMPPRosterDelegate
-(void)xmppRoster:(XMPPRoster *)sender didReceiveRosterPush:(XMPPIQ *)iq{
    // 延迟一点时间,让数据保存到数据库,再去查
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 重新获取
        [self.fetchedResultsController performFetch:nil];
        // 刷新数据
        [self.tableView reloadData];
    });
}

#pragma mark - 懒加载
-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // 存储器
    XMPPRosterCoreDataStorage *storage = [XMPPRosterCoreDataStorage sharedInstance];
    // 实例化,指定要查询的实体,可以去框架里的resources/XMPPRoster.xcdatamodel
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    // 排序描述器
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"jidStr" ascending:YES];
    request.sortDescriptors = @[sortDesc];
    // 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.subscription == 'both'"];
    request.predicate = predicate;
    
    // 实例化查询结果控制器
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:storage.mainThreadManagedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    
    // 执行查询
    [_fetchedResultsController performFetch:nil];
//    DLog(@"%@",[_fetchedResultsController.fetchedObjects valueForKey:@"jidStr"]);
    for (XMPPUserCoreDataStorageObject *aContacts in _fetchedResultsController.fetchedObjects) {
        DLog(@"%@ == %@",aContacts.jidStr,aContacts.subscription);
    }
    
    
    return _fetchedResultsController;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
