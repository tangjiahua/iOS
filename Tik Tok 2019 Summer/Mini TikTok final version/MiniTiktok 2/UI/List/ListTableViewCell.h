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
#import "../Comment/CommentListView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ShowCommentProtocal <NSObject>

@required
-(void) ShowCommentViewWithItem:(ItemModel *)item;

@end

@protocol writeComment <NSObject>

-(void) writeCommentToItem:(ItemModel *)item;

@end

@interface ListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)configWithModel:(ItemModel *)item forIndexPath:(NSIndexPath *)indexPath;
- (void)didEndDisplayModel:(ItemModel *)item forIndexPath:(NSIndexPath *)indexPath;
- (void)playVideo;
- (void)pauseVideo;

@property (nonatomic, weak) id ShowCommentdelegate;
@property (nonatomic, weak) id WriteCommentlegate;

@end

NS_ASSUME_NONNULL_END
