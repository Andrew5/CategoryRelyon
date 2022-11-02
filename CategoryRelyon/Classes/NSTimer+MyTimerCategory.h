//
//  NSTimer+MyTimerCategory.h
//  TestDemo
//
//  Created by jabraknight on 2020/11/3.
//  Copyright © 2020 黄定师. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (MyTimerCategory)
+ (NSTimer *)PF_ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:
(void(^)(void))block repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
