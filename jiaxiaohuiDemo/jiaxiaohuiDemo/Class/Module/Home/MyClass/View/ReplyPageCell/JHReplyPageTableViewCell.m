//
//  JHReplyPageTableViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/24.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHReplyPageTableViewCell.h"
#import "JHImageShowView.h"
#import "JHReplyPageModel.h"
#import "JHReplyPageCellFrame.h"

@interface JHReplyPageTableViewCell()
@property(nonatomic,strong)UILabel *replyContentLabel;

@end


@implementation JHReplyPageTableViewCell

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"pageCell";
    JHReplyPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHReplyPageTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
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
    // 内容
    UILabel *replyContentLabel = [[UILabel alloc] init];
    replyContentLabel.numberOfLines = 0;
    replyContentLabel.font = [UIFont systemFontOfSize:15];
    replyContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:replyContentLabel];
    self.replyContentLabel = replyContentLabel;
    
    // 获取有图片的数组
    JHReplyPageModel *replyPageModel = self.replyPageCellFrame.replyPageModel;
    NSArray *hasImageArray = [self.replyPageCellFrame hasImageArrayWithArray:replyPageModel.image];
    // 创建imgView
    JHImageShowView *imgView = [JHImageShowView initWithCountOfItems:hasImageArray.count];
}

-(void)setReplyPageCellFrame:(JHReplyPageCellFrame *)replyPageCellFrame{
    _replyPageCellFrame = replyPageCellFrame;
    
}















@end
