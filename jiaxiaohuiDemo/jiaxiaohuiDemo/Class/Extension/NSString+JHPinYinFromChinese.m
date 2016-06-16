//
//  NSString+JHPinYinFromChinese.m
//  JiaXiaoHui_iOS
//
//  Created by 陈钰全 on 16/5/27.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import "NSString+JHPinYinFromChinese.h"

@implementation NSString (JHPinYinFromChinese)
/// 汉子转拼音
+(NSString *)transfromCodeWithString:(NSString *)string{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:string];
    NSString *str = [[NSString alloc] init];
    if ([string length]) {
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }//不可缺,否则下面的无法得出结果
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSString *string1 = ms.copy;
            /// 删除空格
            str = [string1 stringByReplacingOccurrencesOfString:@" " withString:@""];
//            NSLog(@"pinyin: %@", str);
        }
    }
    return str;
}
@end
