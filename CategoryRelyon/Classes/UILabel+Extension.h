//
//  UILabel+Extension.h
//  Test
//
//  Created by Rillakkuma on 2018/2/11.
//  Copyright © 2018年 Rillakkuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
/// @param lineSpacing 间距数值

+ (void)changeLineSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing;

/// @param wordSpacing 间距数值

+ (void)changeWordSpacingForLabel:(UILabel *)label wordSpacing:(float)wordSpacing;

/// @param lineSpacing 行间距数值

/// @param wordSpacing 字间距数值

+ (void)changeSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing wordSpace:(float)wordSpacing;


@end
