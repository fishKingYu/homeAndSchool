//
//  JHXMPPManager.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/29.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHXMPPManager.h"
// 打印相关
#import <DDLog.h>
#import <DDTTYLogger.h>
#import <XMPPLogging.h>


@interface JHXMPPManager()<XMPPStreamDelegate,XMPPAutoPingDelegate,XMPPRosterDelegate,XMPPIncomingFileTransferDelegate>
// 密码
@property(nonatomic,copy)NSString *password;
// 登陆成功回调
@property(nonatomic,copy) void(^loginSuccessHandle)();
// 登陆失败回调
@property(nonatomic,copy) void(^loginErrorHandle)(NSError *);
//文件发送者
@property (nonatomic, strong) XMPPJID *fileFrom;
@end

@implementation JHXMPPManager

+(instancetype)sharedInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 *  实例化xmppstream
 *
 *  @return xmppstream
 */
-(XMPPStream *)xmppStream{
    if (_xmppStream != nil) {
        return _xmppStream;
    }
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 配置主机名和端口号
    _xmppStream.hostName = jh_Host_Name;
    _xmppStream.hostPort = jh_Host_Port;
    // 配置打印机 - 打印XMPP框架里发送和接收的数据
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLogLevel:XMPP_LOG_FLAG_SEND_RECV];
    // 配置颜色打印
    // 允许打印颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // 指定相应内容打印的颜色
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:[UIColor grayColor] forFlag:XMPP_LOG_FLAG_SEND];
    // 接收:蓝色
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:[UIColor grayColor] forFlag:XMPP_LOG_FLAG_RECV_POST];
    
    // 激活心跳模块
    [self setupModulse];
    
    return _xmppStream;
}


-(void)loginWithUserName:(NSString *)userName password:(NSString *)password successHandle:(void(^)())successHandle errorHandle:(void(^)(NSError *))errorHandle{
    // 认证时使用
    self.password = password;
    //
    self.loginSuccessHandle = successHandle;
    self.loginErrorHandle = errorHandle;
    
    // 连接前要给流绑定JID, 指定用户名/域/资源
    self.xmppStream.myJID = [XMPPJID jidWithUser:userName domain:jh_XMPP_Domian resource:jh_XMPP_Resource];
    
    // 链接xmpp的XML流, timeout:超时事件
    NSError *error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        DLog(@"%@",error);
    }
}

#pragma mark - 模块
/**
 *  创建模块,心跳检测,ping服务器
 */
-(void)setupModulse{
    // 模块使用基本上遵循以下3个步骤
    // 1.创建
    // 2.配置
    // 3.激活
    
    // 心跳检测模块
    [self createPingModel];
    
    // 断线重连模块
    [self createReconnectModel];
    
    // 花名册模块
    [self createRosterStorageModel];
    
    // 聊天记录模块
    [self createChatModel];
    
    // 文件接收模块
    [self createIncomingModel];
    
    // 文件发送模块
    [self createOutgoingModel];
}

/**
 *  心跳检测模块
 */
-(void)createPingModel{
    /******************* 心跳检测 *******************/
    // 1.创建
    self.xmppAutoPing = [[XMPPAutoPing alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    // 添加打理
    [self.xmppAutoPing addDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 2.配置
    // ping的频率
    self.xmppAutoPing.pingInterval = 3;
    self.xmppAutoPing.pingTimeout = 2;
    // 相应别人的ping
//    self.xmppAutoPing.respondsToQueries = YES;
    // 3.激活-在某个流上激活
//    [self.xmppAutoPing activate:self.xmppStream];
}

/**
 *  断线重连模块
 */
-(void)createReconnectModel{
    /******************* 断线重连 *******************/
    // 1.创建
    self.xmppReconnect = [[XMPPReconnect alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    // 2.配置
    self.xmppReconnect.autoReconnect = YES;
    // 延迟
    self.xmppReconnect.reconnectDelay = 3;
    // 尝试连接频率,如果连接失败再次尝试连接的频率
    self.xmppReconnect.reconnectTimerInterval = 3;
    // 激活
//    [self.xmppReconnect activate:self.xmppStream];
}

/**
 *  花名册模块
 */
-(void)createRosterStorageModel{
    /******************* 花名册模块 *******************/
    // 1.创建
    // 存储器: 以后只要是存储器,都是一个单例
    XMPPRosterCoreDataStorage *rosterStorage = [XMPPRosterCoreDataStorage sharedInstance];
    self.xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:rosterStorage dispatchQueue:dispatch_get_main_queue()];
    // 添加代理
    [self.xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //2.配置
    //是否自动接收别人对我们的订阅
    self.xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = NO;
    //在xmpp流断开连接的时候,是否清楚本地存储的用户和资源
    self.xmppRoster.autoClearAllUsersAndResources = NO;
    // 一连接流是否自动获取花名册(联系人列表),如果为no,则需要手动获取
    self.xmppRoster.autoFetchRoster = YES;
    
    // 延迟一段时间,保证已经激活,再获取
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.xmppRoster fetchRoster]; // 手动获取
//    });
    
    // 激活
    [self.xmppRoster activate:self.xmppStream];
}

/**
 *  聊天模块
 */
-(void)createChatModel{
    // 1.创建
    XMPPMessageArchivingCoreDataStorage *messageStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    self.xmppMessageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:messageStorage dispatchQueue:dispatch_get_main_queue()];
    // 2.配置-无需配置
    // 3.激活
    [self.xmppMessageArchiving activate:self.xmppStream];
}

/**
 *  文件接收模块
 */
-(void)createIncomingModel{
    /******************* 文件接收 *******************/
    // 1.创建
    self.xmppIncomingFileTransfer = [[XMPPIncomingFileTransfer alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    // 设置代理
    [self.xmppIncomingFileTransfer addDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 2.设置
    // 是否则定接收文件,如果为NO,则需要手动接收
    self.xmppIncomingFileTransfer.autoAcceptFileTransfers = NO;
    // 3.激活
    [self.xmppIncomingFileTransfer activate:self.xmppStream];
}

/**
 *  文件发送模块
 */
-(void)createOutgoingModel{
    /******************* 文件发送 *******************/
    // 1.创建
    self.xmppOutgoingFileTransfer = [[XMPPOutgoingFileTransfer alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    // 2.配置-无需配置
    
    // 3.激活
    [self.xmppOutgoingFileTransfer activate:self.xmppStream];
}

#pragma mark - XMPPStreamDelegate
/**
 *  socket链接成功
 *
 *  @param sender
 *  @param socket
 */
-(void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket{
    
}

/**
 *  XML流链接成功
 *
 *  @param sender XML流
 */
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    // 认证
    [self.xmppStream authenticateWithPassword:self.password error:nil];
}

/**
 *  认证成功
 *
 *  @param sender
 */
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    // 登陆成功回调
    self.loginSuccessHandle();
    
    // 出席 - 直接创建会默认是在线状态
    XMPPPresence *presence = [XMPPPresence presence];
    // 自定义在线状态文本, "在线"状态下status无效,其他状态有效
    XMPPElement *statusE = [XMPPElement elementWithName:@"status" stringValue:@"我在开会"];
    [presence addChild:statusE];
    // 使用XML流来发送
    [self.xmppStream sendElement:presence];
}


/**
 *  认证失败
 */
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    
    //构建错误
    NSError *aError = [NSError errorWithDomain:@"CZXMPPAuthDomian" code:001 userInfo:@{NSLocalizedDescriptionKey:error}];
    
    //登陆失败回调
    self.loginErrorHandle(aError);
}

#pragma mark - XMPPAutoPingDelegate
/**
 *  ping发送成功
 */
-(void)xmppAutoPingDidSendPing:(XMPPAutoPing *)sender{
    
}

/**
 *  接收到ping相应成功
 */
-(void)xmppAutoPingDidReceivePong:(XMPPAutoPing *)sender{
    
}

/**
 *  ping超时
 */
-(void)xmppAutoPingDidTimeout:(XMPPAutoPing *)sender{
    
}

#pragma mark - XMPPRosterDelegate
/**
 *  接收到好友订阅请求
 */
-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    //手动接受,From:要接受谁的订阅请求 AddToRoster:是否添加到花名册
    //接受
    [sender acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
}

/**
 *  开始获取好友
 */
-(void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender withVersion:(NSString *)version{
    
}

/**
 *  每获取到一个好友都会调用
 */
-(void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(DDXMLElement *)item{
    
}

/**
 *  获取好友结束
 */
-(void)xmppRosterDidEndPopulating:(XMPPRoster *)sender{
    
}

/**
 *  好友关系发生变化,订阅情况发生改变
 */
-(void)xmppRoster:(XMPPRoster *)sender didReceiveRosterPush:(XMPPIQ *)iq{
    
}


#pragma mark - XMPPIncomingFileTransferDelegate
/**
 *  收到文件传输邀请
 */
-(void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didReceiveSIOffer:(XMPPIQ *)offer{
    // 记录文件发送者
    self.fileFrom = offer.from;
    // 手动接收文件传输邀请
    [self.xmppIncomingFileTransfer acceptSIOffer:offer];
}


-(void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didSucceedWithData:(NSData *)data named:(NSString *)name{
    // 1.获取documentPath路径
    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 2.拼接全路径
    NSString *filePath = [documentPath stringByAppendingPathComponent:name];
    //3.把接收到的文件写入
    [data writeToFile:filePath atomically:YES];
    
    //自己打包消息
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.xmppStream.myJID];
    //body
    [message addBody:name];
    //消息的frome 有非空约束
    [message addAttributeWithName:@"from" stringValue:self.fileFrom.bare];
    
    [[XMPPMessageArchivingCoreDataStorage sharedInstance] archiveMessage:message outgoing:NO xmppStream:self.xmppStream];
    
    
}












@end
