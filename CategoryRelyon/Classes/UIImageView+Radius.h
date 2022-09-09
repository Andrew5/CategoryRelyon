//
//  UIImageView+Radius.h
//  testSingature
//
//  Created by jabraknight on 2022/3/6.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Radius)
/**
 *  圆形
 */
- (void)xf_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

/**
 *  方形或者圆角型
 */
- (void)xf_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

/**
 *  六边形
 */
- (void)xf_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

- (void)xf_setPingxing4SideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

- (void)xf_setPoooingxing4SideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;
@end

NS_ASSUME_NONNULL_END
