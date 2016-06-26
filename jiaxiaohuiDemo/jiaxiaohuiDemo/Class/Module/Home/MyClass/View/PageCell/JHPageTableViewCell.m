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
#import "JHPageImageCollectionViewCell.h"
#import "JHReplyPageTableViewCell.h"

@interface JHPageTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
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
// 展开按钮
@property(nonatomic,strong)UIButton *openButton;
// MP3时间
@property(nonatomic,strong)UILabel *mp3TimeLabel;
// MP3播放条
@property(nonatomic,strong)UIView *mp3PlayView;
// 回复列表tableview
@property(nonatomic,strong)UITableView *replyTableView;
@end


@implementation JHPageTableViewCell

+(instancetype)settingCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"pageCell";
    JHPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHPageTableViewCell alloc] initWithStyle:style reuseIdentifier:ID];
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
    // 内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:contentLabel]; 
    self.contentLabel = contentLabel;
    
    // 展开/收起按钮
    UIButton *openButton = [[UIButton alloc] init];
    [openButton setTitle:@"展开" forState:UIControlStateNormal];
    [openButton setBackgroundColor:[UIColor grayColor]];
    [openButton addTarget:self action:@selector(openButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:openButton];
    self.openButton = openButton;
    
    // 图片collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100); // 设置每个item的大小
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0); // 设置内边距
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout]; // 这里赋值的frame不起作用
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    // 注册cell
    [collectionView registerClass:[JHPageImageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    [self.contentView addSubview:collectionView];
    self.imgCollectionView = collectionView;
    
    // 录音播放
    UIView *mp3View = [[UIView alloc] init];
    mp3View.backgroundColor = [UIColor grayColor];
    // MP3播放按钮
    UIButton *mp3PlayButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [mp3PlayButton setBackgroundImage:[UIImage imageNamed:@"play_audio"] forState:UIControlStateNormal];
    [mp3PlayButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateSelected];
    [mp3View addSubview:mp3PlayButton];
    // 进度条
    UIProgressView *mp3ProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 20, 160, 2)];
    mp3ProgressView.progressViewStyle= UIProgressViewStyleDefault;
    [mp3View addSubview:mp3ProgressView];
    // 播放时间
    UILabel *mp3TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 40, 30)];
    [mp3View addSubview:mp3TimeLabel];
    [self.contentView addSubview:mp3View];
    self.mp3TimeLabel = mp3TimeLabel;
    self.mp3PlayView = mp3View;
    
    // 回复列表
    UITableView *replyTableView = [[UITableView alloc] init];
    replyTableView.delegate = self;
    replyTableView.dataSource = self;
    [self.contentView addSubview:replyTableView];
    self.replyTableView = replyTableView;
    
}
 

/**
 *  数据源
 *
 *  @param pageCellFrame 帖子cell的frame
 */
-(void)setPageCellFrame:(JHPageCellFrame *)pageCellFrame{
    _pageCellFrame = pageCellFrame;
    // 根据数据源创建按钮
    [self creatMoreView];
    // 设置数据源
    [self settingData];
    // 设置frame
    [self settingFrame];
    // 设置展开关闭按钮
    [self setOpenButtonTitle];
}

/**
 *  根据数据源判断是否要隐藏MP3播放进度条
 */
-(void)creatMoreView{
    if (self.mp3PlayView != nil) {
        self.mp3PlayView.hidden = YES;
    }
    // mp3播放进度条
    NSString *mp3UrlString = self.pageCellFrame.classPageModel.mp3Url;
//    DLog(@"mp3地址:%@",mp3UrlString);
    if (![NSString isBlankString:mp3UrlString]) {
        self.mp3PlayView.hidden = NO;
    }
}

/**
 *  设置展开关闭按钮
 */
-(void)setOpenButtonTitle{
    [self.openButton setTitle:self.pageCellFrame.isOpenCellHeight ? @"收起" : @"展开" forState:UIControlStateNormal];
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
    self.mp3TimeLabel.text = [NSString stringWithFormat:@"%@s",pageModel.mp3_duration];
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
    self.openButton.frame = self.pageCellFrame.openButtonFrame;
    self.imgCollectionView.frame = self.pageCellFrame.imgCollectionFrame;
    self.mp3PlayView.frame = self.pageCellFrame.mp3PlayViewFrame;
    self.replyTableView.frame = self.pageCellFrame.replyTableViewFrame;
    self.contentLabel.backgroundColor = [UIColor grayColor];
}

#pragma mark - collectionView 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    JHPageCellFrame *cellF = self.pageCellFrame;
//    DLog(@"cell内的item数%lu",(unsigned long)[cellF hasImageArray].count);
    return [cellF hasImageArray].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //1.获得可重用的cell
    JHPageImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    //2.对cell进行赋值
    NSArray *arr = [self.pageCellFrame hasImageArray];
    cell.imageName = arr[indexPath.item][@"url"];
    
//    DLog(@"图片url:  %@",cell.imageName);
    return cell;
}

#pragma mark - reply tableview 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHReplyPageTableViewCell *replyCell = [JHReplyPageTableViewCell settingCellWithTableView:tableView style:UITableViewCellStyleDefault];
    replyCell.textLabel.text = @"想吃屎吗";
    replyCell.backgroundColor = [UIColor grayColor];
    return replyCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

#pragma mark - 按钮点击事件
/**
 *  展开按钮点击事件
 *
 *  @param button 展开按钮
 */
-(void)openButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(openCell:)]) {
        [self.delegate openCell:button];
    }
}



@end
