//
//  JHChildModel.h
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/6/1.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JHChildModel <NSObject>
@end
@interface JHChildModel : NSObject
@property (nonatomic, copy) NSString *childID;
@property (nonatomic, copy) NSString *name;
@end
