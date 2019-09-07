//
//  DetailViewController.h
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

- (instancetype)initWithModel:(ImageModel *)model;

@end

NS_ASSUME_NONNULL_END

