//
//  UIView+CornerRadius.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)


/// 绘制裁剪圆角，可选任意角进行切割
/// @param radius 圆角半径
/// @param fillColor 填充色
/// @param type 裁剪角
- (void)drawCircularBeadImageWithRadius:(float)radius fillColor:(UIColor *)fillColor CornerStyle:(UIRectCorner)type;

/// 绘制裁剪圆角，可选任意角进行切割，且每个角可选切割任意半径
/// @param radius_TL 左上角半径
/// @param radius_TR 右上角半径
/// @param radius_BL 左下角半径
/// @param radius_BR 右下角半径
/// @param fillColor 填充色
- (void)drawCircularBeadImageWithRadius_TL:(float)radius_TL
                                 radius_TR:(float)radius_TR
                                 radius_BL:(float)radius_BL
                                 radius_BR:(float)radius_BR
                                 fillColor:(UIColor *)fillColor;

// 新版
/**
 设置一个四角圆角

 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角

 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角

 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
@interface CALayer (XWAddForRoundedCorner)

@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
NS_ASSUME_NONNULL_END
