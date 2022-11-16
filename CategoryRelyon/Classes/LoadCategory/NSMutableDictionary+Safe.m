//
//  NSMutableDictionary+Safe.m
//  KVOTest
//
//  Created by StriEver on 16/8/5.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>
#import "NSObject+ImpChangeTool.h"
@implementation NSMutableDictionary (Safe)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self SwizzlingMethod:@"st_removeObjectForKey:" systemClassString:@"NSMutableDictionary" toSafeMethodString:@"removeObjectForKey:" targetClassString:@"__NSDictionaryM"];
        [self SwizzlingMethod:@"st_setObject:forKey:" systemClassString:@"NSMutableDictionary" toSafeMethodString:@"setObject:forKey:" targetClassString:@"__NSDictionaryM"];
        
        
//        SEL originalSelector = @selector(setObject:forKey:);
//        SEL swizzledSelector = @selector(dhSetObject:forKey:);
//
//        Method originalMethod1 = class_getClassMethod(self, originalSelector);
//        Method swizzledMethod2 = class_getClassMethod(self, swizzledSelector);
//
//        BOOL didAddMethod =
//        class_addMethod(self,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod2),
//                        method_getTypeEncoding(swizzledMethod2));
//
//        if (didAddMethod) {
//            class_replaceMethod(self,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod1),
//                                method_getTypeEncoding(originalMethod1));
//        } else {
//            method_exchangeImplementations(originalMethod1, swizzledMethod2);
//        }
    });
}
- (void)st_removeObjectForKey:(id)key {
    if (!key) {
        self[key] = nil;
        return;
    }
    [self st_removeObjectForKey:key];
}
- (void)st_setObject:(id)obj forKey:(id <NSCopying>)key {
    if (!obj) {
        return;
    }
    if (!key) {
        self[key] = nil;
        return;
    }
    [self st_setObject:obj forKey:key];
}

- (void)dhSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }else{
        self[aKey] = nil;
    }
}
@end
