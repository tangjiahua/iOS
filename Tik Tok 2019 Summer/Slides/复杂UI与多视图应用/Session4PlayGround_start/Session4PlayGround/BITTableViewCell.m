//
//  BITTableViewCell.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/14.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "BITTableViewCell.h"
#import "UIView+BITAddtions.h"

@interface BITTableViewCell ()



@end

@implementation BITTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    // 添加子视图，注意是向contentView添加
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageview.frame = [UIScreen mainScreen].bounds;
    self.filmImageView = [[UIImageView alloc] init];
    self.filmImageView.frame = [UIScreen mainScreen].bounds;
    [self.contentView addSubview:self.filmImageView];
    
    self.filmTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, UIScreen.mainScreen.bounds.size.height-150,  UIScreen.mainScreen.bounds.size.width, 100)];
    ;
    self.filmTitleLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.filmTitleLabel];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}


@end
