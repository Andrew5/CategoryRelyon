//
//  UIDevice+StateHeight.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/12/5.
//

#import "UIDevice+StateHeight.h"

@implementation UIDevice (StateHeight)
 
// 顶部安全区高度
+ (CGFloat)device_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}
 
// 底部安全区高度
+ (CGFloat)device_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}
 
//顶部状态栏高度（包括安全区）
+ (CGFloat)device_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}
 
// 导航栏高度
+ (CGFloat)device_navigationBarHeight {
    return 44.0f;
}
 
// 状态栏+导航栏的高度
+ (CGFloat)device_navigationFullHeight {
    return [UIDevice device_statusBarHeight] + [UIDevice device_navigationBarHeight];
}
 
// 底部导航栏高度
+ (CGFloat)device_tabBarHeight {
    return 49.0f;
}
 
// 底部导航栏高度（包括安全区）
+ (CGFloat)device_tabBarFullHeight {
    return [UIDevice device_statusBarHeight] + [UIDevice device_safeDistanceBottom];
}
 
@end
