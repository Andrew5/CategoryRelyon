//
//  UILabel+LeftRightDisplay.h
//  testSingature
//
//  Created by jabraknight on 2021/12/9.
//  Copyright © 2021 Jabraknight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LeftRightDisplay)
//两端对齐

- (void)textAlignmentLeftAndRight;

//指定Label以最后的冒号对齐的width两端对齐

- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;


- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
