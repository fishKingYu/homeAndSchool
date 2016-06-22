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

@interface JHPageTableViewCell : UITableViewCell
@property (nonatomic, strong) JHClassPageListModel *classPageModel; //班级帖子数据模型

@property(nonatomic,strong)JHPageCellFrame *pageCellFrame;

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
