//
//  UIImage+TPCategory.m
//  beautify
//
//  Created by user on 14/11/27.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "UIImage+TPCategory.h"

@implementation UIImage (TPCategory)

+ (UIImage *)stretchImage:(UIImage *)image
                capInsets:(UIEdgeInsets)capInsets
             resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *resultImage = nil;
    double systemVersion = [[UIDevice currentDevice].systemVersion doubleValue];
    if (systemVersion >= 6.0)
    {
        resultImage = [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    }
    else if (systemVersion >= 5.0)
    {
        resultImage = [image resizableImageWithCapInsets:capInsets];
    }
    else
    {
        resultImage = [image stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
    return resultImage;
}

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 atPosition:(CGRect)frame
{
    UIGraphicsBeginImageContext(image2.size);
    
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    // Draw image2
    [image1 drawInRect:frame];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageWithString:(NSString *)base64String{
    base64String = [base64String stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];//[[NSData alloc] initWithBase64Encoding:string];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

@end
