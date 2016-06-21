//
//  JHClassPageListModel.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHClassPageListModel.h"
#import <MJExtension.h>

@implementation JHClassPageListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{ 
    return @{
             @"ID":@"id"
             };
}
@end
