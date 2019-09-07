//
//  CommentListViewController.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model/ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentListView : UIView

- (instancetype)initWithItem:(ItemModel *)item;

@end

NS_ASSUME_NONNULL_END
