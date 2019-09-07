//
//  BITFilmDetailViewController.h
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BITFilmModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BITFilmDetailViewController : UIViewController

// 添加属性接收传递来的数据模型
@property (nonatomic, strong) BITFilmModel *filmModel;

// 添加返回按钮点击时的block属性

@end

NS_ASSUME_NONNULL_END
