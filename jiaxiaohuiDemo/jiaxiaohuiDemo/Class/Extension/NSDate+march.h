//
//  NSDate+march.h
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/5/10.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (march)

/**
 *   比较from和self的时间差值
 *
 *  @param from 需要比较的时间
 *
 *  @return 返回时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  时间转换成时间戳
 *
 *  @param date 时间
 *
 *  @return 返回时间戳
 */
+ (NSString *)getTimeStampWithDate:(NSDate *) date;

/**
 *  时间戳转换成时间
 *
 *  @param timeStamp 时间戳
 *
 *  @return 返回时间
 */
+ (NSDate *)getDateWithTimeStamp:(NSString *) timeStamp;

/**
 *  无时间差的时间
 *
 *  @param anyDate 需要检测的时间
 *
 *  @return 返回时间差的时间
 */
+ (NSDate *)getNowDateFromatAnDate:(NSDate *) anyDate;

/**
 *  将本地日期字符串转为UTC日期字符串
 *
 *  @param localDate 本地日期格式:2013-08-03 12:53:51 可自行指定输入输出格式
 *
 *  @return 将本地日期字符串转为UTC日期字符串
 */
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate;

/**
 *  将UTC日期字符串转为本地时间字符串
 *
 *  @param utcDate 输入的UTC日期格式2013-08-03T04:53:51+0000
 *
 *  @return 将UTC日期字符串转为本地时间字符串
 */
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;

/**
 *  时间字符串转成NSDate
 *
 *  @param dateString 时间字符串
 *  @param dateFormat 时间格式
 *
 *  @return NSDate
 */
+(NSDate *)marchDateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/**
 *  NSDate转成字符串
 *
 *  @param date       日期
 *  @param dateFormat 时间格式
 *
 *  @return 时间字符串
 */
+(NSString *)marchStingFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *  返回当天的最后时间戳  2016-1-1 23:59:59
 *
 *  @param timeStamp 时间戳
 *
 *  @return 当天的最后时间戳
 */
+(NSString *)marchTimeStampEndByDayWithTimeStamp:(NSString *)timeStamp;

/**
 *  返回当天的第一个时间戳    2016-1-1 00:00:00
 *
 *  @param timeStamp 时间戳
 *
 *  @return 返回当天的第一个时间戳
 */
+(NSString *)marchTimeStampBeginByDayWithTimeStamp:(NSString *)timeStamp;

/**
 *  根据时间戳获取规则时间
 *
 *  @param timeStamp 时间戳
 *
 *  @return 返回规则时间
 */
+(NSString *)getRuleTime:(NSString *)timeStamp;
@end
