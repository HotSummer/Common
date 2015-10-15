//
//  UIImage+TPCategory.h
//  beautify
//
//  Created by user on 14/11/27.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TPCategory)

//图片拉伸
+ (UIImage *)stretchImage:(UIImage *)image
                capInsets:(UIEdgeInsets)capInsets
             resizingMode:(UIImageResizingMode)resizingMode;
//图片叠加
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 atPosition:(CGRect)frame;
//压缩图片
+ (UIImage *)scaleFromImage: (UIImage *) image toSize: (CGSize) size;
//等比率缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize;
//颜色转换成image
+ (UIImage*) createImageWithColor: (UIColor*) color;

/**
 *  base64字符转成image
 *
 *  @param base64String base64字符
 *
 *  @return 一个image
 */
+ (UIImage *)createImageWithString:(NSString *)base64String;

/**
 *  将图片转换为圆角图
 *
 *  @param image 图片
 *  @param size  size
 *  @param r     圆角半径
 *
 *  @return 圆角图
 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

@end
