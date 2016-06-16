//
//  NSString+march.h
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/5/10.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (march)
/**
 *  md5 16位
 *
 *  @return 返回MD5值
 */
- (NSString *)marchMd5String;

/**
 *  计算文字所占大小
 *
 *  @param maxSize  限制最大范围
 *  @param fontSize 字体大小
 *
 *  @return 返回文字大小CGSize
 */
- (CGSize)sizeWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;

/**
 *  检查字符是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回是否为空
 */
+ (BOOL) isBlankString:(NSString *)string;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

@end
