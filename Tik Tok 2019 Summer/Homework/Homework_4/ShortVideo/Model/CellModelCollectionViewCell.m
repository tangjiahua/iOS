//
//  CellModelCollectionViewCell.m
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "CellModelCollectionViewCell.h"

@implementation CellModelCollectionViewCell

- (instancetype)initWithName:(NSString *)imageName iconImageName:(NSString *)iconImageName
{
    self = [super init];
    if (self) {
//        _filmName = [name copy];
        _imageName = [imageName copy];
        _imageIcon = [iconImageName copy];
    }
    return self;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"Hero name:%@", self.imageName];
}

@end
