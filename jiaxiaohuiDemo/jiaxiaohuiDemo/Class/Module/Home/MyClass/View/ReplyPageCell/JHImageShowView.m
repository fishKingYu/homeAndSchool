//
//  JHImageShowView.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/25.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHImageShowView.h"
@interface JHImageShowView() 
@end

@implementation JHImageShowView

+(instancetype)initWithCountOfItems:(NSInteger)itemsCount{
    JHImageShowView *jhBackScrollView = [[JHImageShowView alloc] init];
    CGFloat itemW = 100;
    CGFloat itemH = 100;
    CGFloat padding = 10;
    NSInteger rowItemCount = 3; // 每行item个数
    NSInteger rows = itemsCount / (rowItemCount + 0.5) + 1; // 行数
    
    CGFloat scrollViewW = padding * (rowItemCount - 1) + itemW * rowItemCount;
    CGFloat scrollViewH = itemH + (itemH + padding) * (rows-1);
    // 滚动范围
    jhBackScrollView.contentSize = CGSizeMake(scrollViewW, scrollViewH);
    // 创建item
    for (int i=0; i<itemsCount; i++) {
        CGFloat itemButtonW = itemW;
        CGFloat itemButtonH = itemH;
        CGFloat itemButtonX = (itemButtonW + padding) * (i % 3);
        CGFloat itemButtonY = (itemButtonH + padding) * (i / 3);
        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(itemButtonX, itemButtonY, itemButtonW, itemButtonH)];
        [jhBackScrollView addSubview:itemButton];
    }
    return jhBackScrollView;
}

-(void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
}

@end
