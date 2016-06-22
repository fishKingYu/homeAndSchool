//
//  JHPageTableViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/21.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHPageTableViewCell.h"
#import "JHPageCellFrame.h"
#import "JHClassPageListModel.h"
#import "UIImageView+WebCache.h"

@interface JHPageTableViewCell()
// 头像
@property(nonatomic,strong)UIImageView *logoImageView;
// 昵称
@property (nonatomic, strong) UILabel *nameLabel;
// 身份 ,老师/家长
@property(nonatomic,strong)UILabel *statusLabel;
// 日期时间
@property(nonatomic,strong)UILabel *dateLabel;
// 帖子内容
@property(nonatomic,strong)UILabel *contentLabel;
@end


@implementation JHPageTableViewCell

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"pageCell";
    JHPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHPageTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
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
 *  初始化
 */
-(void)setupView{
    // 头像
    UIImageView *loImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:loImageView];
    self.logoImageView = loImageView;
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    // 身份
    UILabel *statusLabel = [[UILabel alloc] init];
    [self.contentView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    // 日期时间
    UILabel *dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    // 日期时间
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  数据源
 *
 *  @param pageCellFrame 帖子cell的frame
 */
-(void)setPageCellFrame:(JHPageCellFrame *)pageCellFrame{
    _pageCellFrame = pageCellFrame;
    // 设置数据源
    [self settingData];
    // 设置frame
    [self settingFrame];
}

/**
 *  设置数据源
 */
-(void)settingData{
    JHClassPageListModel *pageModel = self.pageCellFrame.classPageModel;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:pageModel.logo] placeholderImage:[UIImage imageNamed:@"default_user_attention"]];
    self.nameLabel.text = pageModel.nickname;
    self.statusLabel.text = [pageModel.type isEqualToString:@"1"] ? @"老师" : @"家长";
    self.dateLabel.text = pageModel.addtime;
    self.contentLabel.text = pageModel.content;
}

/**
 *  设置frame
 */
-(void)settingFrame{
    self.logoImageView.frame = self.pageCellFrame.logoFrame;
    self.nameLabel.frame = self.pageCellFrame.nameFrame;
    self.statusLabel.frame = self.pageCellFrame.statusFrame;
    self.dateLabel.frame = self.pageCellFrame.dateFrame;
    self.contentLabel.frame = self.pageCellFrame.contentFrame;
    [self.contentLabel sizeToFit];
    CGSize size = [self.contentLabel sizeThatFits:CGSizeMake(self.contentLabel.frame.size.width, MAXFLOAT)];
    self.contentLabel.frame =CGRectMake(60, 60, SCWidth - 70, size.height);
    self.contentLabel.backgroundColor = [UIColor grayColor];
}

-(void)setClassPageModel:(JHClassPageListModel *)classPageModel{
    _classPageModel = classPageModel;
    self.nameLabel.text = @"测试不就知道了么";
}

//-(UILabel *)nameLabel{
//    if (_nameLabel == nil) {
//        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 60)];
//        _nameLabel.textColor = [UIColor redColor];
//        [self.contentView addSubview:_nameLabel];
//    }
//    return _nameLabel;
//}

@end
