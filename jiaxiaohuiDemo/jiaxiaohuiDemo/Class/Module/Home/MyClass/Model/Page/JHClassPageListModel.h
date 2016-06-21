//
//  JHClassPageListModel.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHPageImageModel.h"
#import "JHGoodListModel.h"
#import "JHReplyPageModel.h"

@protocol JHClassPageListModel <NSObject>
@end
@interface JHClassPageListModel : NSObject
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *mp4Url;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSArray <JHPageImageModel> *image;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *mp3_duration;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *fname;
@property (nonatomic, copy) NSArray <JHGoodListModel> *goodList;
@property (nonatomic, copy) NSString *worker;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray <JHReplyPageModel> *reply;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *good;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *mp3Url;
@property (nonatomic, copy) NSString *uid;
@end
