//
//  JHMyClassPageModel.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHClassPageListModel.h"
#import "JHChildModel.h"
#import "JHClassesPageResponseModel.h"
// 我的班级板块帖子模型
@interface JHMyClassPageModel : NSObject
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *bgImage;
@property (nonatomic, copy) NSString *pagecount;
@property (nonatomic, copy) NSString *userCount;
@property (nonatomic, copy) NSString *replyCount;
@property (nonatomic, strong) NSArray <JHChildModel> *child; // 孩子列表
@property (nonatomic, strong) NSArray <JHClassPageListModel> *list; // 帖子列表
@property (nonatomic, strong) NSArray <JHClassesPageResponseModel> *school; // 班级列表
@end
