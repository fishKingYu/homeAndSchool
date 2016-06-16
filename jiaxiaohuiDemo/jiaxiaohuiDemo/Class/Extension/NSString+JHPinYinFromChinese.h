//
//  NSString+JHPinYinFromChinese.h
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/5/27.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JHPinYinFromChinese)
/// 汉子转拼音
+(NSString *)transfromCodeWithString:(NSString *)string;
@end
