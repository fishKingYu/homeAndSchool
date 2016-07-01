//
//  JHChatBgView.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/7/1.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHChatBgView.h"

@interface JHChatBgView()
@property(nonatomic,strong)UIImage *bgImage;
@property(nonatomic,assign)BOOL isOutgoing;
@end

@implementation JHChatBgView


- (void)drawRect:(CGRect)rect {
    [self.bgImage drawInRect:rect];
    // 绘制气泡
    NSString *bubbleName = self.isOutgoing? @"SenderTextNodeBkg" : @"ReceiverTextNodeBkg";
//    UIImage *bubbleImg = [UIImage imageNamed:bubbleName];
        UIImage *bubbleImg = [[UIImage imageNamed:bubbleName] stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    [bubbleImg drawInRect:rect blendMode:kCGBlendModeSourceIn alpha:1];
    
}

- (void)setImage:(UIImage *)img andIsoutgooing:(BOOL)isOutgoing{
    
    self.bgImage = img;
    self.isOutgoing = isOutgoing;
    
    //重新绘制
    [self setNeedsDisplay];
    
}

@end
