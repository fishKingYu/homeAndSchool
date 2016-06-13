//
//  JHBaseNavigationController.m
//  jiaXiaoHui
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHBaseNavigationController.h"

@interface JHBaseNavigationController ()

@end

@implementation JHBaseNavigationController

// 当类加载到内存的时候就会调用(应用启动完成),不管你程序有没有使用这个类都会调用这个方法
// 第三方：拖进来什么事都没事，已经生效了(键盘处理)
+ (void)load {
    //    NSLog(@"load");
}

// 当第一次使用的时候，才会调用
+ (void)initialize {
    //    NSLog(@"initialize");
    // 前面的self是代表调用的类，
    // 判断是哪个类在调用此方法。如果是当前类，而不是子类的话就调用我们设置导航栏的方法
    if (self == [JHBaseNavigationController class]) {
        NSLog(@"run code");
        // 获取全局对象 appearance UIView都可以使用此方法来获取全局对象(相册，发短信)
        UINavigationBar *bar = [UINavigationBar appearance];
        // 设置背景图片
        /*
         UIBarMetricsDefault, 横屏竖屏都可以使用
         UIBarMetricsCompact, 只有横屏可以使用
         */
        [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
        
        // 设置背景颜色
        //    bar.barTintColor = [UIColor redColor];
        // 设置返回按钮剪头的颜色(会影响他的子view）
        bar.tintColor = [UIColor whiteColor];
        
        
        NSDictionary *att = @{
                              NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName : [UIFont systemFontOfSize:17.f]
                              };
        [bar setTitleTextAttributes:att];
        
        UIBarButtonItem *item = [UIBarButtonItem appearance];
        
        [item setTitleTextAttributes:att forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //    NSLog(@"push");
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
