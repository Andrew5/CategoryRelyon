//
//  NSMutableDictionary+Safe.h
//  KVOTest
//
//  Created by StriEver on 16/8/5.
//  Copyright © 2016年 StriEver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
