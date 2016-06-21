//
//  JHChildModel.m
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/6/1.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import "JHChildModel.h"
#import <MJExtension.h>

@implementation JHChildModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    
    return @{
             @"childID":@"id"
             };
}
@end
