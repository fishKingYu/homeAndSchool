//
//  JHReplyPageCellFrame.h
//  jiaxiaohuiDemo
//
//  Created by 天叶 on 16/6/24.
//  Copyright © 2016年 jiaXiaoHui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHReplyPageModel;

@interface JHReplyPageCellFrame : NSObject
// 回复内容
@property(nonatomic,assign)CGRect replyContentFrame;
// 回复图片
@property(nonatomic,assign)CGRect replyImgCollectionViewFrame;
// 回复MP3播放条
@property(nonatomic,assign)CGRect replyMp3ViewFrame;
// cell的高度
@property(nonatomic,assign)CGFloat replyCellHeight;
// 回复帖子数据模型
@property(nonatomic,strong)JHReplyPageModel *replyPageModel;

/**
 *  返回有图片的数组
 *
 *  @return 有图片的数组回调
 */
-(NSMutableArray *)hasImageArrayWithArray:(NSArray *)array;
@end
