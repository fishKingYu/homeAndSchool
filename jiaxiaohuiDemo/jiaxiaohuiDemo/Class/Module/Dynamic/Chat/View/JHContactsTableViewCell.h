//
//  JHContactsTableViewCell.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHContactModel;

@interface JHContactsTableViewCell : UITableViewCell

@property(nonatomic,strong)JHContactModel *contactModel;


+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;


@end
