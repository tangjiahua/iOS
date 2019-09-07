//
//  UIView+BITAddtions.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "UIView+BITAddtions.h"

@implementation UIView (BITAddtions)

- (void)setBit_top:(CGFloat)bit_top {
    self.frame = CGRectMake(self.bit_left, bit_top, self.bit_width, self.bit_height);
}

- (CGFloat)bit_top {
    return self.frame.origin.y;
}

- (void)setBit_bottom:(CGFloat)bit_bottom {
    self.frame = CGRectMake(self.bit_left, bit_bottom - self.bit_height, self.bit_width, self.bit_height);
}

- (CGFloat)bit_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBit_left:(CGFloat)bit_left {
    self.frame = CGRectMake(bit_left, self.bit_top, self.bit_width, self.bit_height);
}

- (CGFloat)bit_left {
    return self.frame.origin.x;
}

- (void)setBit_right:(CGFloat)bit_right {
    self.frame = CGRectMake(bit_right - self.bit_width, self.bit_top, self.bit_width, self.bit_height);
}

- (CGFloat)bit_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBit_width:(CGFloat)bit_width {
    self.frame = CGRectMake(self.bit_left, self.bit_top, bit_width, self.bit_height);
}

- (CGFloat)bit_width {
    return self.frame.size.width;
}

- (void)setBit_height:(CGFloat)bit_height {
    self.frame = CGRectMake(self.bit_left, self.bit_top, self.bit_width, bit_height);
}

- (CGFloat)bit_height {
    return self.frame.size.height;
}

- (CGFloat)bit_centerX {
    return self.center.x;
}

- (void)setBit_centerX:(CGFloat)bit_centerX {
    self.center = CGPointMake(bit_centerX, self.center.y);
}

- (CGFloat)bit_centerY {
    return self.center.y;
}

- (void)setBit_centerY:(CGFloat)bit_centerY {
    self.center = CGPointMake(self.center.x, bit_centerY);
}

- (CGSize)bit_size {
    return self.frame.size;
}

- (void)setBit_size:(CGSize)bit_size {
    self.frame = CGRectMake(self.bit_left, self.bit_top, bit_size.width, bit_size.height);
}

- (CGPoint)bit_origin {
    return self.frame.origin;
}

- (void)setBit_origin:(CGPoint)bit_origin {
    self.frame = CGRectMake(bit_origin.x, bit_origin.y, self.bit_width, self.bit_height);
}



@end
