//
//  UIView+CornerRadius.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/8/20.
//


#import "UIView+CornerRadius.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "ZBCornerRadiusTool.h"

@implementation UIView (CornerRadius)

- (void)drawCircularBeadImageWithRadius:(float)radius fillColor:(UIColor *)fillColor CornerStyle:(UIRectCorner)type {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self);
    }];
    [self layoutIfNeeded];
    
//    imgView.image = [ZBCornerRadiusTool drawAntiRoundedCornerImageWithRadius:radius rectSize:imgView.frame.size fillColor:fillColor cornerStyle:type];
}

- (void)drawCircularBeadImageWithRadius_TL:(float)radius_TL
                             radius_TR:(float)radius_TR
                             radius_BL:(float)radius_BL
                             radius_BR:(float)radius_BR
                             fillColor:(UIColor *)fillColor {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.equalTo(self);
    }];
    [self layoutIfNeeded];
    
//    imgView.image = [ZBCornerRadiusTool drawAntiRoundedCornerWithRadius_TL:radius_TL radius_TR:radius_TR radius_BL:radius_BL radius_BR:radius_BR rectSize:imgView.frame.size fillColor:fillColor];
}


- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self.layer roundedCornerWithRadius:radius cornerColor:color];
}

- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self.layer roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self.layer roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}
@end

@implementation NSObject (Add)

+ (void)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (XWAddForRoundedCorner)

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end



static void *const MaskCornerRadiusLayerKey = "MaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (XWAddForRoundedCorner)

+ (void)load{
    [CALayer swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_layoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (!color) return;
    CALayer *cornerRadiusLayer = [self getAssociatedValueForKey:MaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self setAssociateValue:cornerRadiusLayer withKey:MaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer setAssociateValue:color withKey:"_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer removeAssociateWithKey:"_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_cornerRadiusImageRadius"];
    [cornerRadiusLayer setAssociateValue:@(corners) withKey:"_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer setAssociateValue:borderColor withKey:"_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer removeAssociateWithKey:"_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer setAssociateValue:@(borderWidth) withKey:"_cornerRadiusImageBorderWidth"];
    UIImage *image = [self getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self getAssociatedValueForKey:MaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer getAssociatedValueForKey:"_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer getAssociatedValueForKey:"_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer getAssociatedValueForKey:"_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer getAssociatedValueForKey:"_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer getAssociatedValueForKey:"_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj getAssociatedValueForKey:"_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj getAssociatedValueForKey:"_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj getAssociatedValueForKey:"_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj getAssociatedValueForKey:"_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj getAssociatedValueForKey:"_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj getAssociatedValueForKey:"_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_cornerRadiusImageSize"];
        [image setAssociateValue:color withKey:"_cornerRadiusImageColor"];
        [image setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_cornerRadiusImageRadius"];
        [image setAssociateValue:@(corners) withKey:"_cornerRadiusImageCorners"];
        if (borderColor) {
            [image setAssociateValue:color withKey:"_cornerRadiusImageBorderColor"];
        }
        [image setAssociateValue:@(borderWidth) withKey:"_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)layoutSublayers{
//    [super layoutSublayers];
    CALayer *cornerRadiusLayer = [self getAssociatedValueForKey:MaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end
