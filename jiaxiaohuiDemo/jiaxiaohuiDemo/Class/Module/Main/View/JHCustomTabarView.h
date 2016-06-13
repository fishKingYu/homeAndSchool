//
//  JHCustomTabarView.h
//  jiaXiaoHui
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHCustomTabarView;

@protocol JHCustomTabarViewDelegate <NSObject>

// 可选
@optional
- (void)customTabBar:(JHCustomTabarView *)tabbar didSelectIndex:(NSInteger)index;
@end

@interface JHCustomTabarView : UIView
@property (nonatomic, weak) id <JHCustomTabarViewDelegate> delegate;
- (void)addBtnWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName;
@end
