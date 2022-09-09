//
//  UIView+ForLMJEndlessLoopScrollView.m
//  LMJEndlessLoopScroll
//
//  Created by Major on 16/3/10.
//  Copyright © 2016年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import "UIView+ForLMJEndlessLoopScrollView.h"

@implementation UIView (ForLMJEndlessLoopScrollView)

- (UIView *)copyView{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
- (UIImage *)asImage {
    UIGraphicsImageRenderer *imageRenderer = [[UIGraphicsImageRenderer alloc]initWithSize:self.bounds.size];
    __block UIImage *image = [UIImage new];
    return [imageRenderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGImageRef imgRef = CGBitmapContextCreateImage(rendererContext.CGContext);
        UIImage* img = [UIImage imageWithCGImage:imgRef];
        CGImageRelease(imgRef);
        CGContextRelease(rendererContext.CGContext);
        image = img;
    }];
}
// 截屏
- (UIImage *)lz_screenshot{
    UIImage *image = [self lz_screenshotWithSize:self.bounds.size];
    return image;
}
- (UIImage *)lz_screenshotWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}
@end
