//
//  UIImage+march.h
//  JiaXiaoHui_iOS
//
//  Created by 赵行军 on 16/5/11.
//  Copyright © 2016年 Hui home school. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (march)
/**
 *  平铺图片
 *
 *  @param imageName 图片名字
 *
 *  @return 图片
 */
+ (instancetype)resizeImage:(NSString *)imageName;

/**
 *  图片压缩成指定大小
 *
 *  @param img  图片
 *  @param size 大小
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  等比例压缩图片
 *
 *  @param sourceImage 图片
 *  @param size        大小
 *
 *  @return 压缩后的图片
 */
+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 *  根据宽度压缩图片
 *
 *  @param sourceImage 图片
 *  @param defineWidth 宽度
 *
 *  @return 压缩后的图片
 */
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
