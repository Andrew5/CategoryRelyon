//
//  NSObject+ValueSafe.m
//  CollegePro
//
//  Created by jabraknight on 2021/12/20.
//

#import "NSObject+ValueSafe.h"

@implementation NSObject (ValueSafe)

- (id)safeValueForKey:(NSString *)key {
    
    id retVal = [self valueForKey:key];
    
    if ([retVal isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return retVal;
}


- (id)safeValueForKeyPath:(NSString *)keyPath {
    id retVal = [self valueForKeyPath:keyPath];
    if ([retVal isEqual:[NSNull null]]) {
        return nil;
    }
    return retVal;
}

@end
