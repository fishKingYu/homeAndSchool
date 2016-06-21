//
//  JHGoodListModel.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/16.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JHGoodListModel <NSObject>
@end
@interface JHGoodListModel : NSObject
@property (nonatomic, copy) NSString *worker;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *nickname;
@end
