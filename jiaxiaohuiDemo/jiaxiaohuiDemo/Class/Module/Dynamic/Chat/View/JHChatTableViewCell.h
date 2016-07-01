//
//  JHChatTableViewCell.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHChatModel.h"
#import "JHChatCellFrame.h"

@interface JHChatTableViewCell : UITableViewCell

@property(nonatomic,strong)JHChatCellFrame *cellFrame; // cell的frame

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@end
