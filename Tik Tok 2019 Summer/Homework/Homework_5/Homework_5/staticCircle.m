//
//  staticCircle.m
//  Homework_5
//
//  Created by 汤佳桦 on 2019/7/16.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import "staticCircle.h"

@implementation staticCircle

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < 4; i++) {
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(115+i*50, 275, 50, 50)];
            circle.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];                     circle.layer.cornerRadius = 25;
            [self addSubview:circle];
        }
        return self;
    }
    return self;
}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        for (int i = 0; i < 5; i++) {
//            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(100+i*50, 100, 50, 50)];
//            self.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];                     self.layer.cornerRadius = 25;
//            self.layer.cornerRadius = 25;
//            [self addSubview:circle];
//        }
//        return self;
//    }
//    return self;
//}
@end
