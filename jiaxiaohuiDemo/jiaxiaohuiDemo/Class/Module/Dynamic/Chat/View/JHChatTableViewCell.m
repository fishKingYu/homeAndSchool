//
//  JHChatTableViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/30.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHChatTableViewCell.h"
#import "JHChatModel.h"
#import "JHChatBgView.h"

@interface JHChatTableViewCell()
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)JHChatBgView *contentBgImageView;
@end

@implementation JHChatTableViewCell

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"pageCell";
    JHChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHChatTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
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
    // 用户头像
    self.logoImageView = [[UIImageView alloc] init];
    self.logoImageView.image = [UIImage imageNamed:@"DefaultHead"];
    [self.contentView addSubview:self.logoImageView];
    
    // 聊天泡背景
    self.contentBgImageView = [[JHChatBgView alloc] init];
    self.contentBgImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentBgImageView];
    
    // 聊天内容框
    self.contentLabel = [[UILabel alloc] init];
//    self.contentLabel.textAlignment = NSTextAlignmentRight;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
}

-(void)setCellFrame:(JHChatCellFrame *)cellFrame{
    _cellFrame = cellFrame;
    // 设置数据源
    [self settingData];
    // 设置frame
    [self settingFrame];
}


/**
 *  设置数据源
 */
-(void)settingData{
    self.contentLabel.text = self.cellFrame.chatModel.chatContent;
//    NSString *imageName = self.cellFrame.chatModel.isOutgoing ? @"SenderTextNodeBkg" : @"ReceiverTextNodeBkg";
    UIImage *bgImage = [[UIImage alloc] init];
    if (self.cellFrame.chatModel.isImage) {
        //1.获取Documents路径
        NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //2.拼接全路径
        NSString *filePath = [documentPath stringByAppendingPathComponent:self.cellFrame.chatModel.imagePath];
        
        //取出图片
//        bgImage = [UIImage imageWithContentsOfFile:filePath];
        bgImage = [UIImage imageNamed:@"girlPicture.jpg"];
    }else{
        bgImage = [UIImage imageNamed:@"girlPicture.jpg"];
    }
    
    // 放大缩小图片,图片不变形
//    UIImage *bgImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    [self.contentBgImageView setImage:bgImage andIsoutgooing:self.cellFrame.chatModel.isOutgoing];
}

/**
 *  设置frame
 */
-(void)settingFrame{
    self.logoImageView.frame = self.cellFrame.logoImageFrame;
    self.contentLabel.frame = self.cellFrame.contentLabelFrame;
    self.contentBgImageView.frame = self.cellFrame.contentBgImageViewFrame;
}



@end
