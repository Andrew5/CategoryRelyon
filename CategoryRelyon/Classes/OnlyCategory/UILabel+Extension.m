//
//  UILabel+Extension.m
//  Test
//
//  Created by Rillakkuma on 2018/2/11.
//  Copyright © 2018年 Rillakkuma. All rights reserved.
//

#import "UILabel+Extension.h"
#import "objc/Runtime.h"
@implementation UILabel (Extension)
- (NSString *)verticalText {
	// 利用runtime添加属性
	return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
	objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
	NSInteger count = str.length;
	for (int i = 1; i < count; i ++) {
		[str insertString:@"\n" atIndex:i*2-1];
	}
	self.text = str;
	self.numberOfLines = 0;
}

/// @param lineSpacing 间距数值
+ (void)changeLineSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing {
    label.numberOfLines = 0;
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];
    label.attributedText = attributedString;
}

/// @param wordSpacing 间距数值
+ (void)changeWordSpacingForLabel:(UILabel *)label wordSpacing:(float)wordSpacing {
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
+ (void)changeSpacingForLabel:(UILabel *)label lineSpacing:(float)lineSpacing wordSpace:(float)wordSpacing {
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
