//
//  JHReplyPageTableViewCell.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/24.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHReplyPageCellFrame;

@interface JHReplyPageTableViewCell : UITableViewCell
// reply的frame
@property(nonatomic,strong)JHReplyPageCellFrame *replyPageCellFrame;


+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@end
