//
//  UILabel+LeftRightDisplay.m
//  testSingature
//
//  Created by jabraknight on 2021/12/9.
//  Copyright © 2021 Jabraknight. All rights reserved.
//

#import "UILabel+LeftRightDisplay.h"
#import <CoreText/CoreText.h>

@implementation UILabel (LeftRightDisplay)
- (void)textAlignmentLeftAndRight{
    
    [self textAlignmentLeftAndRightWith:CGRectGetWidth(self.frame)];
    
}
- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth{
    
    if(self.text==nil||self.text.length==0) {
        
        return;
        
    }
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    NSInteger length = (self.text.length-1);
    
    NSString* lastStr = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    
    if([lastStr isEqualToString:@":"]||[lastStr isEqualToString:@"："]) {
        
        length = (self.text.length-2);
        
    }
    
    CGFloat margin = (labelWidth - size.width)/length;
    
    NSNumber*number = [NSNumber numberWithFloat:margin];
    
    NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
//    NSMutableAttributedString* attribute = [[NSMutableAttributedString alloc] initWithString:self.text attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
//                                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:24]}];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,length)];
    self.attributedText= attribute;
    
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
//    label.text = title;
//    label.font = font;
//    label.numberOfLines = 0;
//    [label sizeToFit];
//    CGFloat height = label.frame.size.height;
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
//    style.lineSpacing = 10 - (self.font.lineHeight - self.font.pointSize);

    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
//    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dic];
//    lb.attributedText = attributeStr;
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    self.numberOfLines = 0;
    return height;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
