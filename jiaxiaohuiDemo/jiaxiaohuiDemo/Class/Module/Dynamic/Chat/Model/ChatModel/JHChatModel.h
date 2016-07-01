//
//  JHChatModel.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHChatModel : NSObject
// 发送/接收内容
@property(nonatomic,copy)NSString *chatContent;
// 是否是发送
@property(nonatomic,assign)BOOL isOutgoing;
// 发送/接收的是否是图片
@property(nonatomic,assign)BOOL isImage;
@property(nonatomic,copy)NSString *imagePath;
@end
