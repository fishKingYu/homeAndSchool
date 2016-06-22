//
//  JHMyClassViewController.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/15.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHMyClassViewController.h"
#import "MJExtension.h"
#import "JHMyClassPageModel.h"
#import "JHChildModel.h"
#import "JHClassPageListModel.h"
#import "JHClassesPageResponseModel.h"
#import "JHPageTableViewCell.h"
#import "JHPageCellFrame.h"

@interface JHMyClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView; //页面主tableview
@property(nonatomic,strong)NSMutableArray *pageModelArray; // 帖子模型列表
@property(nonatomic,strong)JHClassPageListModel *classPageModel; // 帖子数据模型
@end

@implementation JHMyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self setupView];
    
    // 加载数据
    [self getSchoolDynamicPageWith:schoolID];
}

#pragma mark - 初始化界面
/**
 *  初始化界面
 */
-(void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
}



#pragma mark - 网络请求
-(void)getSchoolDynamicPageWith:(NSString *)fid{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"uid"] = userID;
    parms[@"fid"] = @"";//班级id,返回第一个
    parms[@"parentFid"] = fid;//学校id
    parms[@"pageindex"] = @"0";
    parms[@"pagesize"] = @"10";
    parms[@"timestamp"] = realTime;
    parms[@"sign"] = [[[NSString stringWithFormat:@"%@%@%@%@",userID,parms[@"pageindex"],userKey,realTime] marchMd5String]uppercaseString];
    [[JHHTTPManager sharedManager] GET:JHMyClassInfo parameters:parms succeed:^(id responseObj) {
        // 解析
//        JHMyClassPageModel *pageModel = [JHMyClassPageModel mj_objectWithKeyValues:responseObj];
//        NSLog(@"返回的数据%@",pageModel.list);
        self.pageModelArray = [JHClassPageListModel mj_objectArrayWithKeyValuesArray:responseObj[@"list"]];
        [self.mainTableView reloadData];
        NSLog(@"返回数据模型%@",self.pageModelArray);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    DLog(@"不是吧%@",parms[@"parentFid"]);
}



#pragma mark - tableview 代理方法及数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pageModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellID = @"classPageCell";
//    UITableViewCell *classPageCell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (classPageCell == nil) {
//        classPageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    classPageCell.textLabel.text = @"吃屎";
    JHPageTableViewCell *classPageCell = [JHPageTableViewCell settingCellWithTableView:tableView style:UITableViewCellStyleDefault];
    JHPageCellFrame *cellFrame = [[JHPageCellFrame alloc] init];
    cellFrame.classPageModel = self.pageModelArray[indexPath.row];
    classPageCell.pageCellFrame = cellFrame;
    return classPageCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


#pragma mark - 懒加载
-(UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
