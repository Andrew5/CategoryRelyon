//
//  UIColor+KGExtension.m
//  testSingature
//
//  Created by jabraknight on 2022/3/6.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import "UIColor+KGExtension.h"

@implementation UIColor (KGExtension)
+ (UIColor *)kg_colorWithHex:(NSInteger)hexColor {
    return [UIColor colorWithRed:((hexColor & 0xFF0000) >> 16)/255.0 green:((hexColor & 0x00FF00) >> 8) /255.0 blue:( hexColor & 0x0000FF)/255.0 alpha:1.0];
}

+ (UIColor *)kg_colorWithNormalHexColor:(NSInteger)normalHexColor nightHexColor:(NSInteger)nightHexColor {
    NSString *styleStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tagKey"];
    if ([styleStr isEqualToString:@"night"]) {
        return [UIColor kg_colorWithHex:nightHexColor];
    }
    return [UIColor kg_colorWithHex:normalHexColor];
}
@end
