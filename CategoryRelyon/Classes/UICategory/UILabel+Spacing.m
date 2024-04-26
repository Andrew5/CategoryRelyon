//
//  UILabel+Spacing.m
//  loca
//
//  Created by ext.heluoyang on 2022/6/6.
//

#import "UILabel+Spacing.h"

@implementation UILabel (Spacing)
/// @param lineSpacing 间距数值

+ (void)changeLineSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing
{
    label.numberOfLines = 0;

    NSString *labelText = label.text;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = lineSpacing;

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];

    label.attributedText = attributedString;
}

/// @param wordSpacing 间距数值

+ (void)changeWordSpacingForLabel:(UILabel *)label wordSpacing:(float)wordSpacing{

    label.numberOfLines = 0;

    NSString *labelText = label.text;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText

                                                                                         attributes:@{NSKernAttributeName:@(wordSpacing)}];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];

    label.attributedText = attributedString;
}

/// @param lineSpacing 行间距数值

/// @param wordSpacing 字间距数值

+ (void)changeSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing wordSpace:(float)wordSpacing{

    label.numberOfLines = 0;

    NSString *labelText = label.text;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText

                                                                                         attributes:@{NSKernAttributeName:@(wordSpacing)}];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineSpacing = lineSpacing;

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];

    label.attributedText = attributedString;
}








@end
