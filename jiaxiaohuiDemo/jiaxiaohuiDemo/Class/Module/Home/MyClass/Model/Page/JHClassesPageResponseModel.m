//
//  JHClassesPageResponseModel.m
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/6/1.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import "JHClassesPageResponseModel.h"
#import <MJExtension.h>
@implementation JHClassesPageResponseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{ 
    return @{
             @"classID":@"id"
             };
}
@end
