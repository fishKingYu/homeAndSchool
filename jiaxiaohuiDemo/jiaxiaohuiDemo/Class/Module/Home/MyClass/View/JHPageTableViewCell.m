//
//  JHPageTableViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/21.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHPageTableViewCell.h"

@interface JHPageTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
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

-(void)setupView{
    
}


-(void)setClassPageModel:(JHMyClassPageModel *)classPageModel{
    _classPageModel = classPageModel;
    self.nameLabel.text = @"测试不就知道了么";
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 60)];
        _nameLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

@end
