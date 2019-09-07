//
//  SafeDictionary.m
//  SafeDictionaryDemo
//
//  Created by zhangyu on 2019/7/12.
//  Copyright © 2019年 com.bytedance. All rights reserved.
//

#import "SafeDictionary.h"

@interface SafeDictionary()

@property (nonatomic, strong)dispatch_queue_t queue;
@property (nonatomic, strong)NSMutableDictionary *dict;

@end

@implementation SafeDictionary

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("SafeDictionaryQueue",DISPATCH_QUEUE_CONCURRENT);
        self.dict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setObject:(id)anObject forKey:(NSString *)aKey {
    dispatch_barrier_async(self.queue, ^{
        [self.dict setObject:anObject forKey:aKey];
    });
}

- (void)objectForKey:(NSString *)aKey valueHandler:(SafeDictionaryHandler)valueHandler {
    dispatch_async(self.queue, ^{
        if (valueHandler != nil) {
            id value = [self.dict valueForKey:aKey];
            valueHandler(value);
        }
    });
}

@end
