//
//  NSArray+CrashCustom.m
//  CollegePro
//
//  Created by jabraknight on 2020/5/3.
//  Copyright © 2020 jabrknight. All rights reserved.
//

#import "NSArray+CrashCustom.h"

@implementation NSArray (CrashCustom)
+ (void)load{
    [super load];
    //替换不可变数组方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtSafeIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    Method oldSelobjectAtIndex = class_getInstanceMethod(objc_getClass("NSConstantArray"), @selector(objectAtIndexedSubscript:));
    Method newSelobjectAtIndex = class_getInstanceMethod(objc_getClass("NSConstantArray"), @selector(hook_arrFun5ObjectAtIndex:));
    method_exchangeImplementations(oldSelobjectAtIndex, newSelobjectAtIndex);
    //替换可变数组方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(mutableObjectAtSafeIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
}
///数组越界
- (id)hook_arrFun5ObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self hook_arrFun5ObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self hook_arrFun5ObjectAtIndex:index];
    }
}
- (id)objectAtSafeIndex:(NSUInteger)index{

    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
    }else {
        return [self objectAtSafeIndex:index];
    }
}

- (id)mutableObjectAtSafeIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}

@end
