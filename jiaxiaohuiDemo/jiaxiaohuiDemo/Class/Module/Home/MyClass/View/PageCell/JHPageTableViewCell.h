//
//  JHPageTableViewCell.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/21.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMyClassPageModel.h"
@class JHPageCellFrame;
@protocol JHPageTableViewCellDelegate <NSObject>
@optional
-(void)openCell:(UIButton *)button;
@end

@interface JHPageTableViewCell : UITableViewCell
// 展开按钮代理
@property(nonatomic,weak)id<JHPageTableViewCellDelegate> delegate;
// frame数据源
@property(nonatomic,strong)JHPageCellFrame *pageCellFrame;
// 图片collectionView
@property (nonatomic, strong) UICollectionView *imgCollectionView;

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
 
@end
