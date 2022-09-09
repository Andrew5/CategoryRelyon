//
//  NSObject+Simon.h
//  12 kvc的方式
//
//  Created by jabraknight on 2021/3/28.
//

#import <Foundation/Foundation.h>
#import "ICChatServerDefs.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Simon)
// book id
- (NSInteger)bookId;
- (void)setBookId:(NSInteger)_bookId;

// book name
- (NSString *)bookName;
- (void)setBookName:(NSString *)_bookName;

// otherInfo
- (NSDictionary *)otherInfo;
- (void)setOtherInfo:(NSDictionary *)_otherInfo;

//typedef enum
- (MessageDeliveryState)deliveryState;
- (void)setDeliveryState:(MessageDeliveryState)_deliveryState;

//// CGRrct
//- (CGRect)activityF;
//- (void)setActivityF:(CGRect)_activityF;
@end

NS_ASSUME_NONNULL_END
@interface Simon : NSObject{
    
}

@end
