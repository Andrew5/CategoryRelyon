//
//  NSObject+Simon.m
//  12
//
//  Created by jabraknight on 2021/3/28.
//

#import "NSObject+Simon.h"

@implementation NSObject (Simon)


static NSMutableDictionary *_td = nil;

+ (NSMutableDictionary *)_td{
    if (_td == nil) {
        _td = [NSMutableDictionary dictionary];
    }
    return _td;
}


// book id
- (NSInteger)bookId {
    return [[[[self class] _td] objectForKey:@"bookId"] integerValue];
}

- (void)setBookId:(NSInteger)_bookId {
    NSNumber *bookId = [NSNumber numberWithInteger:_bookId];
    [[[self class] _td] setObject:bookId forKey:@"bookId"];
}

// book name
- (NSString *)bookName{
    return [[[self class] _td] objectForKey:@"bookName"];
}
- (void)setBookName:(NSString *)_bookName{
    NSString *bookName = [_bookName copy];
    [[[self class] _td] setObject:bookName forKey:@"bookName"];
//    [bookName release];
}

// otherInfo
- (NSDictionary *)otherInfo{
    return [[[self class] _td] objectForKey:@"otherInfo"];
}

- (void)setOtherInfo:(NSDictionary *)_otherInfo{
    NSDictionary *otherInfo = [_otherInfo copy];
    [[[self class] _td] setObject:otherInfo forKey:@"otherInfo"];
//    [otherInfo release];
}

//typedef enum
- (MessageDeliveryState)deliveryState{
    return [[[[self class] _td] objectForKey:@"deliveryState"] intValue];
}
- (void)setDeliveryState:(MessageDeliveryState)_deliveryState{
    NSNumber *deliveryState = [NSNumber numberWithInt:_deliveryState];
    [[[self class] _td] setObject:deliveryState forKey:@"deliveryState"];
}

//// CGRrct
//- (CGRect)activityF{
//    return [[[[self class] _td] objectForKey:@"activityF"] CGRectValue];
//}
//- (void)setActivityF:(CGRect)_activityF{
//    NSValue *rectValue = [NSValue valueWithCGRect:_activityF];
//    [[[self class] _td] setObject:rectValue forKey:@"activityF"];
//
//}
@end
@implementation Simon

//static struct { BOOL showCaller = YES, showActual = YES, showReturns = YES, showArguments = YES,
//    showSignature = NO, includeProperties = NO, describeValues = NO, logToDelegate; } params;
//static int indentScale = 2;
//static id delegate;
//
//template <class _M,typename _K>
//static inline bool exists( const _M &map, const _K &key ) {
//    return map.find(key) != map.end();
//}

@end
