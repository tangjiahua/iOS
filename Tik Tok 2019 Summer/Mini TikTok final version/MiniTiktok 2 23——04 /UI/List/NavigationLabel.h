//
//  MainViewController.h
//  Test
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavigationLabel : UILabel

@property (nonatomic, strong) UIButton *homeButton;
@property (nonatomic, strong) UIButton *recButton;
@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, assign) NSInteger nowSelectButton;

- (instancetype)initWithHomeButtonClick:(SEL)homeButtonClick recButtonClick:(SEL)recButtonClick myButtonClick:(SEL)myButtonClick TargetObj:(id)obj;

@end

NS_ASSUME_NONNULL_END
