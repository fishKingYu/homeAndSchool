//
//  JHHTTPManager.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHHTTPManager.h"

@implementation JHHTTPManager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static JHHTTPManager *instance;
    dispatch_once(&onceToken, ^{
        
        // config可以用来配置超时
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // config请求超时设置为15s
        config.timeoutIntervalForRequest = 15;
        
        instance = [[self alloc]initWithBaseURL:JHBaseURL sessionConfiguration:config];
        /// json序列化
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];
        
    });
    
    return instance;
}

/**
 *  GET请求
 *
 *  @param URLString  urlString
 *  @param parameters 参数
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void) GET:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObj))succeed failure:(void (^)(NSError *error))failure{
    
    [[JHHTTPManager sharedManager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succeed) {
            succeed(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error); 
        }
    }];
    
}

/**
 *  POST请求
 *
 *  @param URLString  urlString
 *  @param parameters 参数
 *  @param succeed    成功回调
 *  @param failure    失败回调
 */
- (void) POST:(NSString *)URLString parameters:(id)parameters succeed:(void (^)(id responseObj))succeed failure:(void (^)(NSError *error))failure{
    [[JHHTTPManager sharedManager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succeed) {
            succeed(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
