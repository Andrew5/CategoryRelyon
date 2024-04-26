//
//  NSObject+ValueSafe.h
//  CollegePro
//
//  Created by jabraknight on 2021/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ValueSafe)

- (id)safeValueForKey:(NSString *)key;
- (id)safeValueForKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
