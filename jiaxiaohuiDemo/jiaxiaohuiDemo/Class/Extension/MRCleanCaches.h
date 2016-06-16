//
//  MRCleanCaches.h
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/6/8.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCleanCaches : NSObject

/**
 *  根据路径返回目录或文件的大小
 *
 *  @param path 路径
 *
 *  @return 目录文件大小
 */
+ (double)sizeWithFilePath:(NSString *)path;

/**
 *  得到指定目录下的所有文件
 *
 *  @param dirPath 路径
 *
 *  @return 目录下的所有文件
 */
+ (NSArray *)getAllFileNames:(NSString *)dirPath;

/**
 *  删除指定目录或文件
 *
 *  @param path 路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)clearCachesWithFilePath:(NSString *)path;

/**
 *  清空指定目录下文件
 *
 *  @param dirPath 路径
 *
 *  @return 是否清空成功
 */
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;

@end
