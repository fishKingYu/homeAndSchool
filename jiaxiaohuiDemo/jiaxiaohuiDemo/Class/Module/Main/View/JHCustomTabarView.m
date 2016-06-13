//
//  JHCustomTabarView.m
//  jiaXiaoHui
//
//  Created by 陈钰全 on 16/6/13.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHCustomTabarView.h"
#import "JHTabarButton.h"
@interface JHCustomTabarView ()
@property (nonatomic, strong) UIButton *selectedButton;// 当前被选中的按钮
@end

@implementation JHCustomTabarView
/*
 - (instancetype)initWithFrame:(CGRect)frame {
 if (self = [super initWithFrame:frame]) {
 self.backgroundColor = [UIColor blackColor];
 // 添加五个按钮
 for (int i = 0; i < 5; i ++) {
 // 创建按钮 (如果前面没有换成子类的类型，不能使用子类的方法或者属性)
 CZTabBarButton *btn = [CZTabBarButton buttonWithType:UIButtonTypeCustom];
 
 // 拼接图片名字
 NSString *normalImageName = [NSString stringWithFormat:@"TabBar%d",i + 1];
 NSString *selectedImageName = [NSString stringWithFormat:@"TabBar%dSel",i + 1];
 
 [btn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
 [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
 
 // 把按钮添加到view
 [self addSubview:btn];
 
 // 添加点击事件 点击事件使用 UIControlEventTouchDown 按下去
 [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
 // 判断如果是第一个，就选中
 if (i == 0) {
 //                [self btnClick:btn];
 btn.selected = YES;
 self.selectedButton = btn;
 }
 // 设置tag值
 btn.tag = i;
 }
 }
 return self;
 }
 */

- (void)addBtnWithNormalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    // 创建按钮 (如果前面没有换成子类的类型，不能使用子类的方法或者属性)
    JHTabarButton *btn = [JHTabarButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    // 把按钮添加到view
    [self addSubview:btn];
    
    // 添加点击事件 点击事件使用 UIControlEventTouchDown 按下去
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)btnClick:(UIButton *)btn {
    //    NSLog(@"点击按钮");
    // 取消上一个被选中的按钮
    self.selectedButton.selected = !self.selectedButton.selected;
    // 选中按钮
    btn.selected = !btn.selected;
    
    // 记录当前按钮被选中
    self.selectedButton = btn;
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(customTabBar:didSelectIndex:)]) {
        [self.delegate customTabBar:self didSelectIndex:btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 子控制个数
    NSInteger count = self.subviews.count;
    // 设置brn的frame值
    CGFloat btnW = self.frame.size.width / count;
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0; i < count; i ++) {
        JHTabarButton *btn = self.subviews[i];
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        if (i == 0) {
            //                [self btnClick:btn];
            btn.selected = YES;
            self.selectedButton = btn;
        }
        // 设置tag值
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    
}

@end
