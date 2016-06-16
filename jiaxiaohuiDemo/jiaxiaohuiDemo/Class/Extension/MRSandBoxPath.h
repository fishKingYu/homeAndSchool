//
//  MRSandBoxPath.h
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/6/8.
//  Copyright © 2016年 Hui home school. All rights reserved.
//  获取沙盒中的不同目录

#import <Foundation/Foundation.h>
/**
 （1）Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 （2）Library：存储程序的默认设置或其它状态信息；
     里面又包含两个文件夹Caches和Preference；
     Caches，存放缓存文件，iTunes不会备份此目录
 （3）tmp：提供一个即时创建临时文件的地方
 */

@interface MRSandBoxPath : NSObject

/**
 *   获取沙盒Document的文件目录
 */
+ (NSString *)getDocumentDirectory;

/**
 *  获取沙盒Library的文件目录
 */
+ (NSString *)getLibraryDirectory;

/**
 *  获取沙盒Library/Caches的文件目录
 */
+ (NSString *)getCachesDirectory;

/**
 *  获取沙盒Preference的文件目录
 */
+ (NSString *)getPreferencePanesDirectory;

/**
 *  获取沙盒tmp的文件目录
 */
+ (NSString *)getTmpDirectory;

@end
