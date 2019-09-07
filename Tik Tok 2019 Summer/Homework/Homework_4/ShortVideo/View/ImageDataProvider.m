//
//  ImageDataProvider.m
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "ImageDataProvider.h"

@implementation ImageDataProvider

+ (instancetype)sharedProvider
{
    static ImageDataProvider *_sharedProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProvider = [[ImageDataProvider alloc] init];
    });
    return _sharedProvider;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _CatalinaModel = [[ImageModel alloc] initWithTitle:@"Catalina" AndName:@"Catalina"];
        _ElCapitanModel = [[ImageModel alloc] initWithTitle:@"El Capitan" AndName:@"El Capitan"];
        _HighSierraModel = [[ImageModel alloc] initWithTitle:@"High Sierra" AndName:@"High Sierra"];
        _MojaveModel = [[ImageModel alloc] initWithTitle:@"Mojave" AndName:@"Mojave Day"];
        _SierraModel = [[ImageModel alloc] initWithTitle:@"Sierra" AndName:@"Sierra"];
        _YosemiteModel = [[ImageModel alloc] initWithTitle:@"Yosemite" AndName:@"Yosemite"];
    }
    return self;
}
@end
