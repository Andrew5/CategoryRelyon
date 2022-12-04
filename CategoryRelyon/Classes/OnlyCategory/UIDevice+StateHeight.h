//
//  UIDevice+StateHeight.h
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (StateHeight)

// 顶部安全区高度
+ (CGFloat)device_safeDistanceTop;
 
// 底部安全区高度
+ (CGFloat)device_safeDistanceBottom;
 
// 顶部状态栏高度（包括安全区）
+ (CGFloat)device_statusBarHeight;
 
// 导航栏高度
+ (CGFloat)device_navigationBarHeight;
 
// 状态栏+导航栏的高度
+ (CGFloat)device_navigationFullHeight;
 
// 底部导航栏高度
+ (CGFloat)device_tabBarHeight;
 
// 底部导航栏高度（包括安全区）
+ (CGFloat)device_tabBarFullHeight;

@end

NS_ASSUME_NONNULL_END
