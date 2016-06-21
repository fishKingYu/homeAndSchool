//
//  JHHTTPManager.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#define JHBaseURL [NSURL URLWithString:@"http://api.w.metcd.com/"]

@interface JHHTTPManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

/**
 *  GET请求
 *
 *  @param URLString  urlString
 *  @param parameters 参数
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObj))succeed failure:(void (^)(NSError *error))failure;

/**
 *  POST请求
 *
 *  @param URLString  urlString
 *  @param parameters 参数
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObj))succeed failure:(void (^)(NSError *error))failure;
@end
