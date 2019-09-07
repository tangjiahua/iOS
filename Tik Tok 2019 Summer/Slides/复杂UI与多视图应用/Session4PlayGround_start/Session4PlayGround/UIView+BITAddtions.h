//
//  UIView+BITAddtions.h
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BITAddtions)

@property (nonatomic, assign) CGFloat bit_top;

@property (nonatomic, assign) CGFloat bit_bottom;

@property (nonatomic, assign) CGFloat bit_left;

@property (nonatomic, assign) CGFloat bit_right;

@property (nonatomic, assign) CGFloat bit_width;

@property (nonatomic, assign) CGFloat bit_height;

@property (nonatomic, assign) CGFloat bit_centerX;

@property (nonatomic, assign) CGFloat bit_centerY;

@property (nonatomic, assign) CGSize bit_size;

@property (nonatomic, assign) CGPoint bit_origin;

@end

NS_ASSUME_NONNULL_END
