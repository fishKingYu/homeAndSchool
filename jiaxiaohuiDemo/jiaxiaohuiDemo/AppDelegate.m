//
//  AppDelegate.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "AppDelegate.h"
#import "JHMainTabarController.h"
#import "MMDrawerController.h"
#import "JHLeftDrawerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [application setStatusBarHidden:YES];
//    // 设置状态栏样式
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    // 如果项目在这里初始化,写了很多代码,后面推送的内容必须卸载这里,分享
//
    /// 跳转控制器
    MMDrawerController * drawerController = [self setRootViewController];
    self.drawerController = drawerController;
    self.window.rootViewController = drawerController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 设置抽屉控制器
-(MMDrawerController *)setRootViewController{
    // 左滑抽屉控制器
    JHLeftDrawerViewController *leftDrawerVC = [[JHLeftDrawerViewController alloc] init];
    // 主控制器
    JHMainTabarController *mainVC = [[JHMainTabarController alloc] init];
    // 设置控制器
    MMDrawerController * drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainVC leftDrawerViewController:leftDrawerVC];
    //滑动手势开关抽屉
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    //设置抽屉抽出的宽度
    drawerController.maximumLeftDrawerWidth = SCWidth * 0.5;
    return drawerController;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



























@end
