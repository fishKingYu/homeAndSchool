//
//  NSDate+march.m
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/5/10.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import "NSDate+march.h"

@implementation NSDate (march)
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

+ (NSString *)getTimeStampWithDate:(NSDate *) date{
    return[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
}

+ (NSDate *)getDateWithTimeStamp:(NSString *)timeStamp {
    NSString *arg = timeStamp;
    
    if (![timeStamp isKindOfClass:[NSString class]]) {
        arg = [NSString stringWithFormat:@"%@", timeStamp];
    }
    
    NSTimeInterval time = [timeStamp doubleValue];//因为时差问题要加8小时 == 28800 sec;
    return [NSDate dateWithTimeIntervalSince1970:time];
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

/**
 *  将本地日期字符串转为UTC日期字符串
 *
 *  @param localDate 本地日期格式:2013-08-03 12:53:51 可自行指定输入输出格式
 *
 *  @return 将本地日期字符串转为UTC日期字符串
 */
+(NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

/**
 *  将UTC日期字符串转为本地时间字符串
 *
 *  @param utcDate 输入的UTC日期格式2013-08-03T04:53:51+0000
 *
 *  @return 将UTC日期字符串转为本地时间字符串
 */
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}


+(NSDate *)marchDateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    //return [df dateFromString:dateString];
   return [self getNowDateFromatAnDate:[df dateFromString:dateString]];
}

+(NSString *)marchStingFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return [df stringFromDate:date];
}

+(NSString *)marchTimeStampEndByDayWithTimeStamp:(NSString *)timeStamp
{
    NSDate *date = [NSDate getDateWithTimeStamp:timeStamp];
    NSString *tempTimeString = [NSString stringWithFormat:@"%@ 23:59:59",[NSDate marchStingFromDate:date dateFormat:@"yyyy-MM-dd"]];
    NSDate *newDate = [NSDate marchDateFromString:tempTimeString dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSDate getTimeStampWithDate:newDate];
}

+(NSString *)marchTimeStampBeginByDayWithTimeStamp:(NSString *)timeStamp
{
    NSDate *date = [NSDate getDateWithTimeStamp:timeStamp];
    NSString *tempTimeString = [NSString stringWithFormat:@"%@ 00:00:00",[NSDate marchStingFromDate:date dateFormat:@"yyyy-MM-dd"]];
    NSDate *newDate = [NSDate marchDateFromString:tempTimeString dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSDate getTimeStampWithDate:newDate];
}

+(NSString *)getRuleTime:(NSString *)timeStamp{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    
    NSString *result;
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger now_year = [dateComponent year];
    NSInteger now_day = [dateComponent day];
    
    NSCalendar *when_calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *when_dateComponent = [when_calendar components:unitFlags fromDate:confromTimesp];
    
    NSInteger when_year = [when_dateComponent year];
    NSInteger when_day = [when_dateComponent day];
    NSInteger when_hour = [when_dateComponent hour];
    NSInteger when_minute = [when_dateComponent minute];
    
    if(now_year == when_year){
        if (now_day==when_day) {
            result = [[NSString alloc]initWithFormat:@"今天 %.2ld:%.2ld" , (long)when_hour , (long)when_minute];
        }else if(now_day-when_day==1){
            result = [[NSString alloc]initWithFormat:@"昨天 %.2ld:%.2ld" , (long)when_hour , (long)when_minute];
        }else{
            NSDateFormatter * df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
            result = [df stringFromDate:confromTimesp];
        }
    }else{
        NSDateFormatter * df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        result = [df stringFromDate:confromTimesp];
    }
    
    return  result;
}

@end
