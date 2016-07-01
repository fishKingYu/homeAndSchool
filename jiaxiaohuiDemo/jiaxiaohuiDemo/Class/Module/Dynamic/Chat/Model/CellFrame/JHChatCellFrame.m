//
//  JHChatCellFrame.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHChatCellFrame.h"
#import "JHChatModel.h"

@interface JHChatCellFrame()
@property(nonatomic,assign)CGFloat contentLabelH;
@property(nonatomic,assign)CGFloat contentLabelX;
@end


@implementation JHChatCellFrame

-(void)setChatModel:(JHChatModel *)chatModel{
    _chatModel = chatModel;
    
    // 设置内容label的frame
    CGFloat padding = 10;
    CGFloat logoWH = 50;
    // 如果是自己发出的消息
    CGFloat contentLabelY = padding;
    CGSize contentSize = [self sizeWithString:_chatModel.chatContent font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCWidth - 140, MAXFLOAT)];
    CGFloat contentLabelW = contentSize.width;
    self.contentLabelH = contentSize.height;
    if (chatModel.isOutgoing) {
        self.logoImageFrame = CGRectMake(SCWidth-padding-logoWH, 5, logoWH, logoWH);
        self.contentLabelX = SCWidth - logoWH - padding * 2 - contentLabelW;
    }else{
        self.logoImageFrame = CGRectMake(padding, 5, logoWH, logoWH);
        self.contentLabelX = padding * 2 + logoWH;
    }
    // 文字内容label的frame
    self.contentLabelFrame = CGRectMake(self.contentLabelX, contentLabelY, contentLabelW, self.contentLabelH);
    
    // 文字内容的气泡背景frame
    if (chatModel.isImage) {
        // 图片背景气泡frame
        self.contentBgImageViewFrame = CGRectMake(padding * 2 + logoWH, 5, SCWidth - 140, 140);
    }else{
        self.contentBgImageViewFrame = CGRectMake(self.contentLabelX - 10, contentLabelY - 5, contentLabelW + 20, self.contentLabelH + 20);
    }
     
    // cell 的高度
    CGFloat cellHeight = self.contentLabelH + 2 * padding;
    // 如果高度低于logoImageView的高度,则为logoImageView的高度,否则为contentLabel高度
    if (cellHeight < 70) {
        self.chatCellHeight = 70;
    }else{
        self.chatCellHeight = cellHeight;
    }
    
}

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}
@end
