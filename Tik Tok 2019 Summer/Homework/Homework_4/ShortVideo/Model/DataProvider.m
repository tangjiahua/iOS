//
//  DataProvider.m
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "DataProvider.h"

@implementation DataProvider
+ (instancetype)sharedProvider {
    static DataProvider *_sharedProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProvider = [[DataProvider alloc] init];
    });
    
    return _sharedProvider;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _Sierra = [[CellModelCollectionViewCell alloc] initWithName:@"Catalina" iconImageName:@"Catalina"];
        _Catalina = [[CellModelCollectionViewCell alloc] initWithName:@"Sierra" iconImageName:@"Sierra"];
    }
    return self;
}
@end
