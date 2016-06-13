//
//  JHMainTabarController.m
//  jiaXiaoHui
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHMainTabarController.h"
#import "JHCustomTabarView.h"
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
    
    // 动态创建tabbar 按钮个数
    for (int i = 0; i < self.viewControllers.count; i ++) {
        // 拼接图片名字
        NSString *normalImageName = [NSString stringWithFormat:@"TabBar%d",i + 1];
        NSString *selectedImageName = [NSString stringWithFormat:@"TabBar%dSel",i + 1];
        // 动态添加按钮
        [customTabBar addBtnWithNormalImageName:normalImageName selectedImageName:selectedImageName];
    }
    
}

// 加载子控制器
- (void)loadViewControllers {
    // 首页
    UINavigationController *homeNavigationController = [self controllerWithStoryboardName:@"GroupBuy"];
    // 动态
    UINavigationController *dynamicNavigationController = [self controllerWithStoryboardName:@"Lucky"];
    // 我的
    UINavigationController *myInfoNavigationController = [self controllerWithStoryboardName:@"OpenAward"];
    
    // 方法一
    self.viewControllers = @[homeNavigationController, dynamicNavigationController, myInfoNavigationController];
}

- (UINavigationController *)controllerWithStoryboardName:(NSString *)name {
    // 要从storyboard 里面加载导航栏控制器
    UIStoryboard *hallSB = [UIStoryboard storyboardWithName:name bundle:nil];
    // 要从storyboard 中取出初始化控制器
    UINavigationController *nav = [hallSB instantiateInitialViewController];
    
    return nav;
}

#pragma mark - 自定义tabbar 的代理回调
- (void)customTabBar:(JHCustomTabarView *)tabbar didSelectIndex:(NSInteger)index {
    //    NSLog(@"%zd",index);
    self.selectedIndex = index;
}
@end
