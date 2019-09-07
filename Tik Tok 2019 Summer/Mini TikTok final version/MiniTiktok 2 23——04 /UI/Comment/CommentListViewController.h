//
//  CommentListViewController.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableViewCell.h"
#import "../../Model/ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentListViewController : UIViewController

- (instancetype)initWithItems:(NSArray<ItemModel *> *)items;

@end

NS_ASSUME_NONNULL_END
