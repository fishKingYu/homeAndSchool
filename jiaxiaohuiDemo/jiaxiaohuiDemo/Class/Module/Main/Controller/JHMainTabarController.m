//
//  JHMainTabarController.m
//  jiaXiaoHui
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHMainTabarController.h"
#import "JHCustomTabarView.h"
#import "JHBaseNavigationController.h"
#import "JHHomeViewController.h"
#import "JHDynamicViewController.h"
#import "JHMyInfoViewController.h"

@interface JHMainTabarController ()<JHCustomTabarViewDelegate>

@end

@implementation JHMainTabarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewControllers];
    
    
    // 移除系统的tabbar
    //    [self.tabBar removeFromSuperview];
    // 创建自定义的tabbar
    JHCustomTabarView *customTabBar = [[JHCustomTabarView alloc]init];
    
    // 位置
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    
    // 添加到view 上面
    [self.tabBar addSubview:customTabBar];
    // 添加按钮
    // 首页
    [customTabBar addBtnWithNormalImageName:@"icom_navigation_home" selectedImageName:@"icom_navigation_home_hover"];
    // 动态
    [customTabBar addBtnWithNormalImageName:@"icom_navigation_news" selectedImageName:@"icom_navigation_news_hover"];
    // 我的
    [customTabBar addBtnWithNormalImageName:@"icom_navigation_me" selectedImageName:@"icom_navigation_me_hover"];
    
}

// 加载子控制器
- (void)loadViewControllers {
    // 首页
    JHHomeViewController *homeVC = [[JHHomeViewController alloc] init];
    JHBaseNavigationController *homeNavigationController = [[JHBaseNavigationController alloc] initWithRootViewController:homeVC];
    
    // 动态
    JHDynamicViewController *dynamicVC = [[JHDynamicViewController alloc] init];
    JHBaseNavigationController *dynamicNavigationController = [[JHBaseNavigationController alloc] initWithRootViewController:dynamicVC];
    // 我的
    JHMyInfoViewController *myInfoVC = [[JHMyInfoViewController alloc] init];
    JHBaseNavigationController *myInfoNavigationController = [[JHBaseNavigationController alloc] initWithRootViewController:myInfoVC];
    
    // 子控制器
    self.viewControllers = @[homeNavigationController, dynamicNavigationController, myInfoNavigationController];
}


#pragma mark - 自定义tabbar 的代理回调
- (void)customTabBar:(JHCustomTabarView *)tabbar didSelectIndex:(NSInteger)index {
    //    NSLog(@"%zd",index);
    self.selectedIndex = index;
}
@end
