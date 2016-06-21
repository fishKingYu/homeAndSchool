//
//  JHReplyPageModel.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHQuoteUserModel.h"
#import "JHPageImageModel.h"
@protocol JHReplyPageModel <NSObject>
@end 
@interface JHReplyPageModel : NSObject
@property (nonatomic, copy) NSString *worker;
@property (nonatomic, copy) NSString *mp3_duration;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSArray <JHQuoteUserModel> *quoteUser;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *mp4Url;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray <JHPageImageModel> *image;
@property (nonatomic, copy) NSString *mp3Url; 

@end
