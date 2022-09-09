//
//  UIImage+Ref.h
//  testSingature
//
//  Created by jabraknight on 2022/3/6.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Ref)
/**
 *  返回圆形图片
 */
- (instancetype)xf_circleImage;

+ (instancetype)xf_circleImage:(NSString *)name;
/**
 *  更换皮肤
 *
 *  @param name 图片名
 *
 *  @return 夜间模式的图片名后面拼接N，如 buttonBg -> buttonBgN
 */
+ (UIImage *)kg_imageNamed:(NSString *)name;

- (UIImage *)yy_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
                          borderLineJoin:(CGLineJoin)borderLineJoin;
@end

NS_ASSUME_NONNULL_END
