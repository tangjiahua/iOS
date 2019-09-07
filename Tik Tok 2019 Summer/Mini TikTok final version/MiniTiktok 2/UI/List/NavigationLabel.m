//
//  MainViewController.m
//  Test
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "NavigationLabel.h"
#import "../List/ListViewController.h"

@interface NavigationLabel ()

@end

@implementation NavigationLabel

- (instancetype)initWithHomeButtonClick:(SEL)homeButtonClick recButtonClick:(SEL)recButtonClick myButtonClick:(SEL)myButtonClick TargetObj:(id)obj
{
    CGFloat labelWidth = CGRectGetWidth(UIScreen.mainScreen.bounds);
    CGFloat labelHeight = CGRectGetHeight(UIScreen.mainScreen.bounds) / 18;
    CGFloat topDis = CGRectGetHeight(UIScreen.mainScreen.bounds) - labelHeight;
    CGFloat leftDis = 0;
    self = [super initWithFrame:CGRectMake(leftDis, topDis, labelWidth, labelHeight)];
    self.backgroundColor = [UIColor clearColor];
//    self.alpha = 0.3;
    self.userInteractionEnabled = YES;
    
    self.homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, labelWidth / 3, labelHeight)];
    _homeButton.backgroundColor = [UIColor clearColor];
    [_homeButton setTitle:@"主页" forState:UIControlStateNormal];
    _homeButton.alpha = 1;
    [_homeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_homeButton addTarget:obj action:homeButtonClick forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeButton];
    
    self.recButton = [[UIButton alloc] initWithFrame:CGRectMake(labelWidth / 3, 0, labelWidth / 3, labelHeight)];
    _recButton.backgroundColor = [UIColor clearColor];
    [_recButton setTitle:@"📹" forState:UIControlStateNormal];
    [_recButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_recButton addTarget:obj action:recButtonClick forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_recButton];
    
    self.myButton = [[UIButton alloc] initWithFrame:CGRectMake(labelWidth * 2 / 3, 0, labelWidth / 3, labelHeight)];
    _myButton.backgroundColor = [UIColor clearColor];
    [_myButton setTitle:@"我的" forState:UIControlStateNormal];
    [_myButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_myButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_myButton addTarget:obj action:myButtonClick forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_myButton];
    
    _nowSelectButton = 1;
    [_homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _homeButton.layer.borderWidth = 2;
    _homeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    return self;
}

#pragma mark - override

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
