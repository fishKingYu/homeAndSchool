//
//  JHChatCellFrame.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHChatModel;

@interface JHChatCellFrame : NSObject
@property(nonatomic,assign)CGRect logoImageFrame; // 头像
@property(nonatomic,assign)CGRect contentLabelFrame; // 内容
@property(nonatomic,assign)CGRect contentBgImageViewFrame; // 内容的气泡背景
//@property(nonatomic,assign)CGRect imageFrame; // 发送内容为图片的frame
@property(nonatomic,assign)CGFloat chatCellHeight; // 行高

@property(nonatomic,strong)JHChatModel *chatModel; // 聊天模型
@end
