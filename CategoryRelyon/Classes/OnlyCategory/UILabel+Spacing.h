//
//  UILabel+Spacing.h
//  loca
//
//  Created by ext.heluoyang on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Spacing)
/// @param lineSpacing 间距数值

+ (void)changeLineSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing;

/// @param wordSpacing 间距数值

+ (void)changeWordSpacingForLabel:(UILabel *)label wordSpacing:(float)wordSpacing;

/// @param lineSpacing 行间距数值

/// @param wordSpacing 字间距数值

+ (void)changeSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing wordSpace:(float)wordSpacing;


@end

NS_ASSUME_NONNULL_END
