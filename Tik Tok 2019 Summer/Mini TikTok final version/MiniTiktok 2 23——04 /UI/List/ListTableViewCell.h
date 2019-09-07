//
//  ListTableViewCell.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../Model/ItemModel.h"
#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import <AVFoundation/AVFoundation.h>
#import "../LikeButton/LikeButton.h"
#import "../../Animation/YPDouYinLikeAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configWithModel:(ItemModel *)item forIndexPath:(NSIndexPath *)indexPath;
- (void)didEndDisplayModel:(ItemModel *)item forIndexPath:(NSIndexPath *)indexPath;
- (void)playVideo;
- (void)pauseVideo;

@end

NS_ASSUME_NONNULL_END
