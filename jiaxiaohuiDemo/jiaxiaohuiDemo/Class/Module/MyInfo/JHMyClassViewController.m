//
//  JHMyClassViewController.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/15.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHMyClassViewController.h"

@interface JHMyClassViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView; //页面主tableview
@end

@implementation JHMyClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}

#pragma mark - 初始化界面
/**
 *  初始化界面
 */
-(void)setupView{
    [self.view addSubview:self.mainTableView];
}
















#pragma mark - tableview 代理方法及数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"classPageCell";
    UITableViewCell *classPageCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (classPageCell == nil) {
        classPageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSLog(@"你妹");
    classPageCell.textLabel.text = @"吃屎";
    return classPageCell;
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
