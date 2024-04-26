//
//  UIImage+Ref.m
//  testSingature
//
//  Created by jabraknight on 2022/3/6.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import "UIImage+Ref.h"

@implementation UIImage (Ref)
- (instancetype)xf_circleImage {
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)xf_circleImage:(NSString *)name {
    return [[self imageNamed:name] xf_circleImage];
}

+ (UIImage *)kg_imageNamed:(NSString *)name {
    NSString *styleStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"tagkey"];
    if ([styleStr isEqualToString:@"night"]) {
        return [UIImage imageNamed:[name stringByAppendingString:@"N"]];
    }
    return [UIImage imageNamed:name];
}

// YYImage
- (UIImage *)yy_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
                          borderLineJoin:(CGLineJoin)borderLineJoin {
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius,
                                                                                                                                 borderWidth)];
        [path closePath];
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
    }
    return self;
}

- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor*)fillColor completed:(void(^)(UIImage*image))completed {
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        // 看程序执行耗时(把耗时的操作放在子线程中)
        NSTimeInterval start = CACurrentMediaTime();
        // 1. 利用绘图，建立上下文
        UIGraphicsBeginImageContextWithOptions (size, YES , 0 );
        CGRect rect = CGRectMake(0,0, size.width, size.height);
        // 2. 设置被裁切的部分的填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        // 3. 利用 ⻉塞尔路径 实现 裁切 效果
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        // 4. 绘制图像
        [self drawInRect:rect];
        // 5. 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        // 6. 关闭上下文 UIGraphicsEndImageContext ();
        NSLog(@"图片操作耗时:%f 纳秒",CACurrentMediaTime() - start);//干一个活就占了百分之一秒
        // 7. 使用回调，返回结果
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completed) {
                completed(result);
            }
        });
    });
}
@end
