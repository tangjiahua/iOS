//
//  BITTableViewCell.h
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/14.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BITTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *filmImageView;
@property (nonatomic, strong) UILabel *filmTitleLabel;

 + (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
