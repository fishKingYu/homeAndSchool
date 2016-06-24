//
//  JHPageImageCollectionViewCell.m
//  jiaxiaohuiDemo
//
//  Created by 陈钰全 on 16/6/24.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import "JHPageImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface JHPageImageCollectionViewCell()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation JHPageImageCollectionViewCell
//通过代码创建对象的时候会调用这个方法
//在构造方法中设置自定义的控件的属性
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){ 
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imgView = imageView;
    }
    return self;
}

//在此方法中进行布局
//注意:[super layoutSubviews]; 这个一定要写
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor blueColor];
    
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imageName] placeholderImage:[UIImage imageNamed:@"camera"]];
    self.imgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}

- (void)prepareForReuse{
    
}
@end
