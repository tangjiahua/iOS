//
//  ViewController.m
//  SafeDictionaryDemo
//
//  Created by zhangyu on 2019/7/12.
//  Copyright © 2019年 com.bytedance. All rights reserved.
//

#import "ViewController.h"
#import "SafeDictionary.h"

@interface ViewController ()

@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong)SafeDictionary *safeDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dict = [NSMutableDictionary dictionary];
    self.safeDict = [[SafeDictionary alloc] init];
    [self crashFunc]; // 线程不安全的容器
//    [self safeFunc]; // 线程安全的容器
    
@synchronized (self) {
    [self.dict setObject:@"value" forKey:@"key"];
}
}

- (void)crashFunc {
    dispatch_queue_t queue0 = dispatch_queue_create("MyQueue0",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create("MyQueue1",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("MyQueue2",DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue0, ^{
            @synchronized (self) {
                [self.dict setObject:str forKey:str];
            }
//            [self.dict setObject:str forKey:str];
        });
    }
    for (int i = 0; i < 10000; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue1, ^{
            @synchronized (self) {
                [self.dict setObject:str forKey:str];
            }
//            [self.dict setObject:str forKey:str];
        });
    }
    for (int i = 0; i < 10000; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue2, ^{
            @synchronized (self) {
                NSString *value = [self.dict objectForKey:str];
                NSLog(@"%@", value);
            }
//            NSString *value = [self.dict objectForKey:str];
//            NSLog(@"%@", value);
        });
    }
}

- (void)safeFunc {
    dispatch_queue_t queue0 = dispatch_queue_create("MyQueue0",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create("MyQueue1",DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("MyQueue2",DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 100; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue0, ^{
            [self.safeDict setObject:str forKey:str];
        });
    }
    for (int i = 0; i < 100; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue1, ^{
            [self.safeDict setObject:str forKey:str];
        });
    }
    for (int i = 0; i < 100; i++) {
        NSString *str = @(i).stringValue;
        dispatch_async(queue2, ^{
            [self.safeDict objectForKey:str valueHandler:^(id value) {
                NSLog(@"%@", value);
            }];
        });
    }
}


@end
