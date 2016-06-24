//
//  JHPageCellFrame.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/22.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHPageCellFrame.h"
#import "JHClassPageListModel.h"
@interface JHPageCellFrame()
@property(nonatomic,assign)CGFloat maxCellHeight;
@property (nonatomic, assign) CGFloat indexY; // 标记上一个布局控件的坐标y位置
@end

@implementation JHPageCellFrame

-(void)setClassPageModel:(JHClassPageListModel *)classPageModel{
    _classPageModel = classPageModel;
    // 间隙
    CGFloat padding = 10;
    
    // 设置头像的frame
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewW = 40;
    CGFloat iconViewH = 40;
    self.logoFrame = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 设置昵称label的frame
    CGFloat nameLabelX = iconViewW + padding + padding;
    CGFloat nameLabelY = padding;
    CGFloat nameLabelW = SCWidth - nameLabelX;
    CGFloat nameLabelH = 20;
    self.nameFrame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    // 设置身份label的frame
    CGFloat statusLabelX = iconViewW + padding + padding;
    CGFloat statusLabelY = padding + nameLabelH;
    CGFloat statusLabelW = SCWidth - nameLabelX;
    CGFloat statusLabelH = 20;
    self.statusFrame = CGRectMake(statusLabelX, statusLabelY, statusLabelW, statusLabelH);
    
    // 设置日期label的frame
    CGFloat dateLabelX = SCWidth - 100;
    CGFloat dateLabelY = padding;
    CGFloat dateLabelW = 100;
    CGFloat dateLabelH = 20;
    self.dateFrame = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);
    
    // 设置内容label的frame
    CGFloat contentLabelX = padding + iconViewW;
    CGFloat contentLabelY = padding + iconViewH + padding;
    if (self.isOpenCellHeight) {
        self.maxCellHeight = MAXFLOAT;
    }else{
        self.maxCellHeight = 50;
    }
    CGSize contentSize = [self sizeWithString:classPageModel.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCWidth - nameLabelX - padding, self.maxCellHeight)];
    CGFloat contentLabelW = contentSize.width;
    CGFloat contentLabelH = contentSize.height;
    self.contentFrame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    self.indexY = contentLabelY + contentLabelH + padding;
    
    // 判断是否有展开按钮, 有则创建, 没有则不创建
    if ([self isExistOpenButton]) {
        // 展开按钮frame
        CGFloat openButtonX = 50;
        CGFloat openButtonY = self.indexY;
        CGFloat openButtonW = 80;
        CGFloat openButtonH = 30;
        self.openButtonFrame = CGRectMake(openButtonX, openButtonY, openButtonW, openButtonH);
        self.indexY = openButtonY + openButtonH + padding;
    }
    
    // 图片collectionView
    NSArray *imgArray = [self hasImageArray];
    if (imgArray.count != 0) {
        NSInteger line = imgArray.count / 3.5 + 1;
//        DLog(@"行数%ld",(long)line);
        CGFloat collectionViewX = contentLabelX;
        CGFloat collectionViewY = self.indexY;
        CGFloat collectionViewW = SCWidth - nameLabelX - padding;
        CGFloat collectionViewH = (100 + padding * 2) * line;
        self.imgCollectionFrame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
        self.indexY = collectionViewY + collectionViewH + padding;
    }
    
    // 计算cell高度
    self.cellHeight = self.indexY;
}



// 判断是否有展开按钮
-(BOOL)isExistOpenButton{
    CGSize contentCloseSize = [self sizeWithString:self.classPageModel.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCWidth - 70, 50)];
    CGSize contentOpenSize = [self sizeWithString:self.classPageModel.content font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCWidth - 70, MAXFLOAT)];
    if (contentOpenSize.height > contentCloseSize.height) {
        return YES;
    }else{
        return NO;
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

/**
 *  返回有图片的数组
 *
 *  @return 有图片的数组回调
 */
-(NSMutableArray *)hasImageArray {
    NSArray *imageArray = self.classPageModel.image;
    NSMutableArray *hasImgArray = [[NSMutableArray alloc] init];
    for (NSDictionary *imgModel in imageArray) {
        if (![NSString isBlankString: imgModel[@"url"]]) {
            [hasImgArray addObject:imgModel];
        }
    }
    return hasImgArray;
}

@end
