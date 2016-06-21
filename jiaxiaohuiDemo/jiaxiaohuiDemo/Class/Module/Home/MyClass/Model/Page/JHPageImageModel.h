//
//  JHPageImageModel.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JHPageImageModel <NSObject>
@end
@interface JHPageImageModel : NSObject
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlThum;
@end
