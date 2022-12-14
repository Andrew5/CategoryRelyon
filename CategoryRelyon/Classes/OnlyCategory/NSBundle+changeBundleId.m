//
//  NSBundle+changeBundleId.m
//  CategoryRelyon
//
//  Created by jabraknight on 2022/4/28.
//

#import "NSBundle+changeBundleId.h"
#import <objc/runtime.h>
//原包名
#define NSBundle_changeBundleIdentifier_orgBundleId @"NSBundle_changeBundleIdentifier_orgBundleId"

//修改包名
#define NSBundle_changeBundleIdentifier_nowBundleId @"NSBundle_changeBundleIdentifier_nowBundleId"
@implementation NSBundle (changeBundleId)
- (void)setNowBundleId:(NSString *)nowBundleId {
    objc_setAssociatedObject(self, "nowBundleId", nowBundleId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)nowBundleId {
    return objc_getAssociatedObject(self, "nowBundleId");
}

//修改包名
- (void)changeBundleIdentifier:(NSString *)bundleId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"bundleIdentifier"));
        Method m2 = class_getInstanceMethod([self class], NSSelectorFromString(@"_changeB"));
        method_exchangeImplementations(m1, m2);
    });
   
    self.nowBundleId = bundleId;
}

- (NSString *)_changeB {
    if (self.nowBundleId) {
        return self.nowBundleId;
    } else {
        return [self _changeB];
    }
}
@end
