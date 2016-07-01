//
//  JHChatViewController.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHChatViewController.h"
#import "JHChatTableViewCell.h"
#import "JHChatModel.h"

@interface JHChatViewController ()<UITableViewDataSource,UITableViewDelegate,XMPPStreamDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@property(nonatomic,strong)UITableView *tableView;
// 聊天输入框
@property(nonatomic,strong)UIView *chatInputView;
// 输入框
@property(nonatomic,strong)UITextField *inputTextField;
// 发送按钮
@property(nonatomic,strong)UIButton *sendButton;

@end

@implementation JHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupView];
}

/**
 *  初始化界面
 */
-(void)setupView{
    [self.view addSubview:self.tableView];
    [self.navigationController.view addSubview:self.chatInputView];
    // 标题
    self.title = self.jid.bare;
    
    // 代理
    [[JHXMPPManager sharedInstance].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
}

-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // 存储器
    XMPPMessageArchivingCoreDataStorage *messageStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    
    // 实例化
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    // 排序描述器
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[sortDesc];
    // 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.bareJidStr == %@",self.jid.bare];
    request.predicate = predicate;
    
    // 实例化查询结果控制器
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:messageStorage.mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    // 执行查询
    [_fetchedResultsController performFetch:nil];
    
    for (XMPPMessageArchiving_Message_CoreDataObject *aMessageObj in _fetchedResultsController.fetchedObjects) {
        DLog(@"aMessageObj 88888  %@",aMessageObj.body);
    }
    return _fetchedResultsController;
}

#pragma mark - 自定义方法
/**
 *  发送按钮点击事件
 */
-(void)sendButtonAction{
//    [self textFieldShouldReturn:self.inputTextField];
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
    imgPickerController.delegate = self;
    [self presentViewController:imgPickerController animated:YES completion:nil];
}

/**
 *  重新获取数据刷新表格
 */
-(void)fetchData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fetchedResultsController performFetch:nil];
        [self.tableView reloadData];
        
        //主动滚到最后一行
        NSInteger count = self.fetchedResultsController.fetchedObjects.count;
        if (count) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    });
}

/**
 *  返回cell的frame
 *
 *  @param indexPath indexPath
 *
 *  @return cell frame
 */
-(JHChatCellFrame *)getFrameWithIndexPath:(NSIndexPath *)indexPath{
    XMPPMessageArchiving_Message_CoreDataObject *aMessageObj = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    JHChatModel *chatModel = [[JHChatModel alloc] init];
    chatModel.chatContent = aMessageObj.body;
    chatModel.isOutgoing = aMessageObj.isOutgoing;
    if ([aMessageObj.message.subject isEqualToString:@"IMAGE"]) {
        chatModel.isImage = YES;
        chatModel.imagePath = aMessageObj.message.body;
    }else{
        chatModel.isImage = NO;
    }
    
    JHChatCellFrame *chatCellFrame = [[JHChatCellFrame alloc] init];
    chatCellFrame.chatModel = chatModel;
    return chatCellFrame;
}

#pragma mark - imagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    // 将图片转为二进制
    NSData *imgData = UIImageJPEGRepresentation(img, 0.2);
    // 生成唯一名字
    NSString *imgName = [[JHXMPPManager sharedInstance].xmppStream generateUUID];
    // 使用发送附件模块发送
    NSError *error = nil;
    [[JHXMPPManager sharedInstance].xmppOutgoingFileTransfer sendData:imgData named:imgName toRecipient:self.jid description:nil error:&error];
    if (error) {
        DLog(@"发送文件错误:%@",error);
    }
    
    // 把图片写入沙盒
    // 1.获取document路径
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 2.拼接全路径
    NSString *filePath = [documentPath stringByAppendingPathComponent:imgName];
    DLog(@"图片路径%@",filePath);
    // 3.把接收到的文件写入
    [imgData writeToFile:filePath atomically:YES];
    
    // 打包消息
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.jid];
    [message addBody:imgName];
    [[XMPPMessageArchivingCoreDataStorage sharedInstance] archiveMessage:message outgoing:YES xmppStream:[JHXMPPManager sharedInstance].xmppStream];
    // 重新获取
    [self fetchData];
}

#pragma mark - tableview 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedResultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHChatTableViewCell *cell = [JHChatTableViewCell settingCellWithTableView:tableView style:UITableViewCellStyleDefault];
    cell.cellFrame = [self getFrameWithIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHChatCellFrame *chatCellFrame = [self getFrameWithIndexPath:indexPath];
    return chatCellFrame.chatCellHeight;
}

#pragma mark - TextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    // 创建消息
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.jid];
    // 消息体
    [message addBody:textField.text];
    [[JHXMPPManager sharedInstance].xmppStream sendElement:message];
    
    //获取数据刷新表格
    [self fetchData];
    
    return YES;
}


#pragma mark - XMPPStreamDeleage
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.fetchedResultsController performFetch:nil];
//        [self.tableView reloadData];
//    });
    
    [self fetchData];
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UITextField *)inputTextField{
    if (_inputTextField == nil) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, SCWidth - 90, 40)];
        _inputTextField.placeholder = @"聊天输入";
        _inputTextField.delegate = self;
        _inputTextField.backgroundColor = [UIColor whiteColor];
    }
    return _inputTextField;
}

-(UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(SCWidth - 70, 5, 50, 40)];
        [_sendButton setTitle:@"图片" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:[UIColor grayColor]];
        [_sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(UIView *)chatInputView{
    if (_chatInputView == nil) {
        _chatInputView = [[UIView alloc] initWithFrame:CGRectMake(0, SCHeight - 50, SCWidth, 50)];
        [_chatInputView addSubview:self.inputTextField];
        [_chatInputView addSubview:self.sendButton];
        _chatInputView.backgroundColor = [UIColor whiteColor];
    }
    return _chatInputView;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.chatInputView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.chatInputView.hidden = YES;
}

@end
