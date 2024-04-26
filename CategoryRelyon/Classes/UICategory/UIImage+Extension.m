//
//  UIImage+Extension.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "UIImage+Extension.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Extension)


+ (UIImage *)gxz_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 视频第一帧
+ (UIImage *)videoFramerateWithPath:(NSString *)videoPath
{
    NSString *mp4Path = [[videoPath stringByDeletingPathExtension] stringByAppendingPathExtension:@"mp4"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:mp4Path] options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 0;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    if (!thumbnailImageRef) {
        return nil;
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}

// 压缩图片
+ (UIImage *)simpleImage:(UIImage *)originImg
{
    CGSize imageSize = [self handleImage:originImg.size];
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    CGContextClip(contextRef);
    [originImg drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *clipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipedImage;
}

+ (CGSize)handleImage:(CGSize)retSize {
    CGFloat width = 0;
    CGFloat height = 0;
    if (retSize.width > retSize.height) {
        width = [[UIScreen mainScreen] bounds].size.width;
        height = retSize.height / retSize.width * width;
    } else {
        height = [[UIScreen mainScreen] bounds].size.height;
        width = retSize.width / retSize.height * height;
    }
    return CGSizeMake(width, height);
}


+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 1.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //创建路径
    UIBezierPath *path = [self getBezierPath:isSender imageSize:imageSize];
    //把路径添加到上下文中
    CGContextAddPath(contextRef, path.CGPath);
    //裁剪上下文
    CGContextEOClip(contextRef);
    //把图片画到上下文中
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    //从上下文中取出图片
    UIImage *arrowImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return arrowImage;
}

+ (UIBezierPath *)getBezierPath:(BOOL)isSender
                      imageSize:(CGSize)imageSize
{
    CGFloat arrowWidth = 6;
    CGFloat marginTop = 13;
    CGFloat arrowHeight = 10;
    CGFloat imageW = imageSize.width;
    UIBezierPath *path;
    if (isSender) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width - arrowWidth, imageSize.height) cornerRadius:6];
        [path moveToPoint:CGPointMake(imageW - arrowWidth, 0)];
        [path addLineToPoint:CGPointMake(imageW - arrowWidth, marginTop)];
        [path addLineToPoint:CGPointMake(imageW, marginTop + 0.5 * arrowHeight)];
        [path addLineToPoint:CGPointMake(imageW - arrowWidth, marginTop + arrowHeight)];
        [path closePath];
        
    } else {
  
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15, 0, imageSize.width - 15, imageSize.height) cornerRadius:6];
//一
/// 绘图时,有一个起始点,而这个起始点在绘制一条曲线后会自动移动到曲线的终点. 而使用该方法可以直接移动这个起始点, 这个起始点很重要,是之后每次绘图的起点.
//        [path moveToPoint:CGPointMake(15, 0)];
//        /// 添加一条直线,直线从起始点出发指向终点.
//        [path addLineToPoint:CGPointMake(15, 10)];
//        [path addLineToPoint:CGPointMake(0, 10)];
//        [path addLineToPoint:CGPointMake(15, 20)];

        ///二
        [path moveToPoint:CGPointMake(15, 18)];
        [path moveToPoint:CGPointMake(30, 30)];

        /// 添加一条直线,直线从起始点出发指向终点.
        [path addLineToPoint:CGPointMake(30, 400)];
        [path addLineToPoint:CGPointMake(300, 400)];
        [path addLineToPoint:CGPointMake(300, 0)];
//        [path addLineToPoint:CGPointMake(18, 0)];
//        [path addQuadCurveToPoint:CGPointMake(18, 18) controlPoint:CGPointMake(0, 0)];
        ///三
            /*
        [path moveToPoint: CGPointMake(9.5, 0.5)];
        [path addLineToPoint: CGPointMake(1.5, 0.5)];
        [path addLineToPoint: CGPointMake(9.5, 8.5)];
        [path addLineToPoint: CGPointMake(9.5, 16.5)];
             */
        
        ///原
//        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(arrowWidth, 0, imageSize.width - arrowWidth, imageSize.height) cornerRadius:6];
//        [path moveToPoint:CGPointMake(arrowWidth, 0)];
//        [path addLineToPoint:CGPointMake(arrowWidth, marginTop)];
//        [path addLineToPoint:CGPointMake(0, marginTop + 0.5 * arrowHeight)];
//        [path addLineToPoint:CGPointMake(arrowWidth, marginTop + arrowHeight)];
            
        [path closePath];
    }
    return path;
}

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg
{
    UIGraphicsBeginImageContext(secondImg.size);
    [secondImg drawInRect:CGRectMake(0, 0, secondImg.size.width, secondImg.size.height)];
    [firstImg drawInRect:CGRectMake((secondImg.size.width-firstImg.size.width)*0.5,(secondImg.size.height-firstImg.size.height)*0.5, firstImg.size.width, firstImg.size.height)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg
{
    UIGraphicsBeginImageContext(secondImg.size);
    [secondImg drawInRect:CGRectMake(0, 0,secondImg.size.width,secondImg.size.height)];
    CGFloat firstImgW = secondImg.size.width/4;
    CGFloat firstImgH = secondImg.size.width/4;
    [firstImg drawInRect:CGRectMake((secondImg.size.width-firstImgW)*0.5,(secondImg.size.height-firstImgH)*0.5, firstImgW,firstImgH)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}




@end
