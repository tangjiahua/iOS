//
//  SafeDictionary.h
//  SafeDictionaryDemo
//
//  Created by zhangyu on 2019/7/12.
//  Copyright © 2019年 com.bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SafeDictionaryHandler)(id value);

@interface SafeDictionary : NSObject

- (void)setObject:(id)anObject forKey:(NSString *)aKey;
- (void)objectForKey:(NSString *)aKey valueHandler:(SafeDictionaryHandler)valueHandler;

@end
