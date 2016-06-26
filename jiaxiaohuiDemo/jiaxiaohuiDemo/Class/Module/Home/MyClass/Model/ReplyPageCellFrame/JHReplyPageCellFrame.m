//
//  JHReplyPageCellFrame.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/24.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHReplyPageCellFrame.h"
#import "JHReplyPageModel.h"

@interface JHReplyPageCellFrame()
@property(nonatomic,assign)CGFloat indexY; // 标记控件最大y
@end

@implementation JHReplyPageCellFrame

-(void)setReplyPageModel:(JHReplyPageModel *)replyPageModel{
    _replyPageModel = replyPageModel;
    // 间隙
    CGFloat padding = 10;
    
    // 回复内容的frame
    CGFloat replyContentX = 0;
    CGFloat replyContentY = padding;
    CGSize contentSize = [self sizeWithString:replyPageModel.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCWidth - 60, MAXFLOAT)];
    CGFloat replyContentW = contentSize.width;
    CGFloat replyContentH = contentSize.height;
    self.replyContentFrame = CGRectMake(replyContentX, replyContentY, replyContentW, replyContentH);
    self.indexY = replyContentY + replyContentH + padding;
     
    // 图片collectionView
    NSArray *imgArray = [self hasImageArrayWithArray:replyPageModel.image];
    if (imgArray.count != 0) {
        CGFloat collectionViewX = padding;
        CGFloat collectionViewY = self.indexY;
        CGFloat collectionViewW = SCWidth - padding - padding;
        CGFloat collectionViewH = 100 + padding * 2;
        self.replyImgCollectionViewFrame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
        self.indexY = collectionViewY + collectionViewH + padding;
    }
    
    // mp3播放进度条
    if (![NSString isBlankString:replyPageModel.mp3Url]) {
        CGFloat mp3PlayViewX = replyContentX;
        CGFloat mp3PlayViewY = self.indexY;
        CGFloat mp3PlayViewW = 260;
        CGFloat mp3PlayViewH = 40;
        self.replyMp3ViewFrame = CGRectMake(mp3PlayViewX, mp3PlayViewY, mp3PlayViewW, mp3PlayViewH);
        self.indexY = mp3PlayViewY + mp3PlayViewH + padding;
    }
    
    // cell的高度
    self.replyCellHeight = self.indexY;
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

/**
 *  返回有图片的数组
 *
 *  @return 有图片的数组回调
 */
-(NSMutableArray *)hasImageArrayWithArray:(NSArray *)array {
    NSMutableArray *hasImgArray = [[NSMutableArray alloc] init];
    for (NSDictionary *imgModel in array) {
        if (![NSString isBlankString: imgModel[@"url"]]) {
            [hasImgArray addObject:imgModel];
        }
    }
    return hasImgArray;
}

@end
