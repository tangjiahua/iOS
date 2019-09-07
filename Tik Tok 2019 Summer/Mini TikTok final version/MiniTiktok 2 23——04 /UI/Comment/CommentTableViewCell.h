//
//  CommentTableViewCell.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model/CommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, strong) CommentModel *commentModel;

- (instancetype)initWithItem:(CommentModel *)item;

@end

NS_ASSUME_NONNULL_END
