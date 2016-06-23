//
//  JHPageCellFrame.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/22.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHClassPageListModel;
@interface JHPageCellFrame : NSObject
// 头像frame
@property(nonatomic,assign)CGRect logoFrame;
// 昵称
@property(nonatomic,assign)CGRect nameFrame;
// 身份
@property(nonatomic,assign)CGRect statusFrame;
// 日期
@property(nonatomic,assign)CGRect dateFrame;
// 内容
@property(nonatomic,assign)CGRect contentFrame;
// 展开按钮
@property(nonatomic,assign)CGRect openButtonFrame;
// cell 高度
@property(nonatomic,assign)CGFloat cellHeight;
// 是否展开
@property(nonatomic,assign)BOOL isOpenCellHeight;
// 是否有展开按钮
//@property(nonatomic,assign)BOOL isExistOpenButton;
// 帖子数据模型
@property(nonatomic,weak)JHClassPageListModel *classPageModel;
@end
