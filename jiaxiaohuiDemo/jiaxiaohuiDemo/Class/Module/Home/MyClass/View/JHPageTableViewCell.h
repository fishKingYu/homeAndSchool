//
//  JHPageTableViewCell.h
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/21.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMyClassPageModel.h"

@interface JHPageTableViewCell : UITableViewCell
@property (nonatomic, strong) JHMyClassPageModel *classPageModel; //班级帖子数据模型

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
