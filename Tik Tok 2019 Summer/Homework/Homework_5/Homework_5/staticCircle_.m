//
//  staticCircle_.m
//  Homework_5
//
//  Created by 汤佳桦 on 2019/7/16.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import "staticCircle_.h"

@implementation staticCircle_
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < 4; i++) {
            UIView *circle_ = [[UIView alloc] initWithFrame:CGRectMake(115+i*50, 325, 50, 50)];
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = circle_.bounds;
            gradient.endPoint = CGPointMake(0.5, 1);
            gradient.startPoint = CGPointMake(0.5, 0);
            gradient.colors = @[(id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
            gradient.locations = @[@(0), @(0.35), @(1)];
            circle_.layer.mask = gradient;
            
            circle_.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];
            circle_.layer.cornerRadius = 25;
            [self addSubview:circle_];
        }
        return self;
    }
    return self;
}

@end
