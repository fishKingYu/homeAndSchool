//
//  JHContactsTableViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHContactsTableViewCell.h"
#import "JHContactModel.h"

@interface JHContactsTableViewCell()
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end


@implementation JHContactsTableViewCell

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"pageCell";
    JHContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHContactsTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化界面
        [self setupView];
    }
    return self;
}

/**
 *  初始化界面
 */
-(void)setupView{
    self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 50, 50)];
    self.logoImageView.image = [UIImage imageNamed:@"DefaultHead"];
    [self.contentView addSubview:self.logoImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 40)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLabel];
    
}

-(void)setContactModel:(JHContactModel *)contactModel{
    _contactModel = contactModel;
//    self.logoImageView.image = [UIImage imageNamed:@"DefaultHead"];
    self.nameLabel.text = contactModel.name;
}

@end
