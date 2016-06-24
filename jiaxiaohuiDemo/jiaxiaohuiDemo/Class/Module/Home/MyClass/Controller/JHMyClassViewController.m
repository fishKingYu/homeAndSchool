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

@interface JHMyClassViewController ()<UITableViewDelegate,UITableViewDataSource,JHPageTableViewCellDelegate>
@property (nonatomic, strong) UITableView *mainTableView; //页面主tableview
@property(nonatomic,strong)NSMutableArray *pageModelArray; // 帖子模型列表
@property(nonatomic,strong)JHClassPageListModel *classPageModel; // 帖子数据模型
@property(nonatomic,strong)JHPageCellFrame *cellF;
@property(nonatomic,strong)NSMutableArray *cellFrameArray;
@end

@implementation JHMyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self setupView];
    
    // 加载数据
    [self getSchoolDynamicPageWith:CLASSID];
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
    parms[@"forumID"] = fid;//班级id,返回第一个
//    parms[@"parentFid"] = fid;//学校id
    parms[@"pageindex"] = @"0";
    parms[@"pagesize"] = @"30";
    parms[@"timestamp"] = realTime;
    parms[@"sign"] = [[[NSString stringWithFormat:@"%@%@%@%@%@",userID,fid,parms[@"pageindex"],userKey,realTime] marchMd5String]uppercaseString];
    [[JHHTTPManager sharedManager] GET:JHGetPageList parameters:parms succeed:^(id responseObj) {
        // 解析
        self.pageModelArray = [JHClassPageListModel mj_objectArrayWithKeyValuesArray:responseObj[@"list"]];
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }]; 
}


#pragma mark - 自定义代理
/**
 *  展开收起按钮点击代理
 *
 *  @param button 展开或者收起按钮(为同一按钮,标题不同而已)
 */
-(void)openCell:(UIButton *)button{
    // 获取button所在的cell的NSIndexPath
    JHPageTableViewCell *cell = (JHPageTableViewCell *)[[button superview] superview];
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    DLog(@"展开按钮点击%ld",indexPath.row);
    // 将frame数组的cell从新计算行高
    JHPageCellFrame *cellF = self.cellFrameArray[indexPath.row];
    cellF.isOpenCellHeight = !cellF.isOpenCellHeight;
    // 赋值会从新计算cell的frame
    cellF.classPageModel = self.pageModelArray[indexPath.row];
    [self.mainTableView reloadData];
}


#pragma mark - tableview 代理方法及数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pageModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHPageTableViewCell *classPageCell = [JHPageTableViewCell settingCellWithTableView:tableView style:UITableViewCellStyleDefault];
    classPageCell.pageCellFrame = self.cellFrameArray[indexPath.row];
    classPageCell.delegate = self;
    // 刷新cell内的collectionView
    [classPageCell.imgCollectionView reloadData];
    return classPageCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHPageCellFrame *cellF = self.cellFrameArray[indexPath.row];
    return cellF.cellHeight;
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

/**
 *  懒加载获取cell的height
 *
 *  @return 保存cell的高度数组
 */
-(NSMutableArray *)cellFrameArray{
    if (_cellFrameArray == nil) {
        _cellFrameArray = [[NSMutableArray alloc] init];
        for (JHClassPageListModel *pageModel in self.pageModelArray) {
            JHPageCellFrame *cellFrame = [[JHPageCellFrame alloc] init];
            cellFrame.classPageModel = pageModel;
            [_cellFrameArray addObject:cellFrame];
        }
    }
    return _cellFrameArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
