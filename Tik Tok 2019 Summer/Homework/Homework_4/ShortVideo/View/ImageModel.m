//
//  ImageModel.m
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "ImageModel.h"
@implementation ImageModel

- (instancetype)initWithTitle:(NSString *)title AndName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.imageTitle = [title copy];
        self.image = [UIImage imageNamed:name];
    }
    return self;
}

@end
