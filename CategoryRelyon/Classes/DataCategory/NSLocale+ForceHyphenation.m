//
//  NSLocale+ForceHyphenation.m
//  testSingature
//
//  Created by jabraknight on 2022/3/17.
//  Copyright © 2022 Jabraknight. All rights reserved.
//

#import "NSLocale+ForceHyphenation.h"
#import <objc/runtime.h>

@implementation NSLocale (ForceHyphenation)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        SEL originalSelector = @selector(preferredLanguages);
        SEL swizzledSelector = @selector(sr_preferredLanguages);

        Class class = object_getClass((id)self);
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
+ (NSArray <NSString *> *)sr_preferredLanguages {
    [self sr_preferredLanguages];
    return @[ @"en" ];
}

@end
