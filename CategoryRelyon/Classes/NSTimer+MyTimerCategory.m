//
//  NSTimer+MyTimerCategory.m
//  TestDemo
//
//  Created by jabraknight on 2020/11/3.
//  Copyright © 2020 黄定师. All rights reserved.
//

#import "NSTimer+MyTimerCategory.h"

@implementation NSTimer (MyTimerCategory)
+ (NSTimer *)PF_ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:
(void(^)(void))block repeats:(BOOL)repeats{
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handle:) userInfo:[block copy] repeats:repeats];

}
+ (void)handle:(NSTimer *)timer {
    
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
