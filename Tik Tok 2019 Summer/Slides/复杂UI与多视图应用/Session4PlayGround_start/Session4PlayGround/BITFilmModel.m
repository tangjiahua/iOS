//
//  BITHeroModel.m
//  BITGalary
//
//  Created by 郝一鹏 on 2019/6/30.
//  Copyright © 2019 Me55a. All rights reserved.
//

#import "BITFilmModel.h"

@implementation BITFilmModel

- (instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName iconImageName:(NSString *)iconImageName filmDescription:(NSString *)description
{
    self = [super init];
    if (self) {
        _filmName = [name copy];
        _imageName = [imageName copy];
        _filmDescription = [description copy];
        _filmIcon = [iconImageName copy];
    }
    return self;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"Hero name:%@, description: %@", self.filmName, self.filmDescription];
}

@end
