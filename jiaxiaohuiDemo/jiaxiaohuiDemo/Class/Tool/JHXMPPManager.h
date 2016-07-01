//
//  JHXMPPManager.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/29.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XMPPAutoPing.h>
#import <XMPPReconnect.h>
#import <XMPPRoster.h>
#import <XMPPRosterCoreDataStorage.h>
#import <XMPPMessageArchiving.h>
#import <XMPPMessageArchivingCoreDataStorage.h>
#import "XMPPIncomingFileTransfer.h"
#import "XMPPOutgoingFileTransfer.h"


@interface JHXMPPManager : NSObject
#pragma mark - 属性
// xmpp的XML流
@property(nonatomic,strong)XMPPStream *xmppStream;
// 心跳检测模块
@property(nonatomic,strong)XMPPAutoPing *xmppAutoPing;
// 重连模块
@property(nonatomic,strong)XMPPReconnect *xmppReconnect;
// 花名册模块
@property(nonatomic,strong)XMPPRoster *xmppRoster;
// 聊天记录模块
@property(nonatomic,strong)XMPPMessageArchiving *xmppMessageArchiving;
// 文件接收
@property(nonatomic,strong)XMPPIncomingFileTransfer *xmppIncomingFileTransfer;
// 文件发送
@property(nonatomic,strong)XMPPOutgoingFileTransfer *xmppOutgoingFileTransfer;

#pragma mark - 方法
+ (instancetype)sharedInstance;

/**
 *  登陆返回
 *
 *  @param userName      登陆的用户名
 *  @param password      密码
 *  @param successHandle 登陆成功回调
 *  @param errorHandle   登陆失败回调
 */
-(void)loginWithUserName:(NSString *)userName password:(NSString *)password successHandle:(void(^)())successHandle errorHandle:(void(^)(NSError *))errorHandle;
@end
