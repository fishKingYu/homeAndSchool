//
//  JHImageShowView.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/25.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHImageShowView : UIScrollView
// item的size,不传则默认为(100,100)
@property(nonatomic,assign)CGSize itemSize;
// 行之间的间距,不传则默认为10
@property(nonatomic,assign)CGFloat lineInterval;
// 列之间的距离,不传则默认为10
@property(nonatomic,assign)CGFloat arrangeInterval;
// 创建view初始化方法
+(instancetype)initWithCountOfItems:(NSInteger)itemsCount;

@end
