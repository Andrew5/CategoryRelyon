//
//  NSBundle+changeBundleId.h
//  CategoryRelyon
//
//  Created by jabraknight on 2022/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (changeBundleId)
@property (strong, nonatomic) NSString * nowBundleId;
/**
 修改包名
 @param bundleId 包名，nil为默认包名
 */
- (void)changeBundleIdentifier:(NSString *)bundleId;
@end

NS_ASSUME_NONNULL_END
