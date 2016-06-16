//
//  JHHomeViewController.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/15.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHMyClassViewController.h"

@interface JHHomeViewController ()

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupView];
}

#pragma mark - 初始化界面
/**
 *  初始化界面
 */
-(void)setupView{
    [self createClassButton];
}

#pragma mark - 班级按钮
/**
 *  创建班级按钮
 */
-(void)createClassButton{
    // 添加进入班级按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 100, 50)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitle:@"进入班级" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(classButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

/**
 *  班级按钮点击事件
 */
-(void)classButtonClick{
    JHMyClassViewController *classVC = [[JHMyClassViewController alloc] init];
    [self.navigationController pushViewController:classVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
