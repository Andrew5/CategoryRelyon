//
//  UIColor+JFColor.m
//  JFCalendarPicker
//
//  Created by 保修一站通 on 15/10/1.
//  Copyright (c) 2015年 JF. All rights reserved.
//

#import "UIColor+JFColor.h"

@implementation UIColor (JFColor)
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])//检查开头是0x
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])//检查开头是#
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (instancetype)gradientColorWithSize:(CGSize)size
                            direction:(GradientColorDirection)direction
                           startColor:(UIColor *)startcolor
                                                        endColor:(UIColor *)endColor{
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    if (direction == GradientColorDirectionUpwardDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    
    CGPoint endPoint = CGPointMake(0.0, 0.0);
    switch (direction) {
        case GradientColorDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case GradientColorDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case GradientColorDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            endPoint = CGPointMake(1.0, 0.0);
            break;
    }
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    // 作用于CALayer层的方法,将view的layer渲染到当前的绘制的上下文中
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    // 取得图片
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    // 带图案图像的颜色
    return [UIColor colorWithPatternImage:image];
}

@end
