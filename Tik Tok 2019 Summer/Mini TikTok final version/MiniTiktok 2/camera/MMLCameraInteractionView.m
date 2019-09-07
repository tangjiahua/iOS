//
//  MMLCameraInteractionView.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/16.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLCameraInteractionView.h"

@interface MMLCameraInteractionView ()

@property (nonatomic, strong, readwrite) UIButton *backButton;
@property (nonatomic, strong, readwrite) UIButton *recordButton;
@property (nonatomic, strong, readwrite) UIButton *actionButton;
@property (nonatomic, strong, readwrite) UIButton *filterButton;
//@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation MMLCameraInteractionView

- (NSInteger)Add
{
    self.i = (self.i+1)%4;
    return self.i;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backButton];
        
        NSLayoutConstraint *constraint;
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.backButton
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeTop
                      multiplier:1.0f
                      constant:10.0f];
        [self addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.backButton
                      attribute:NSLayoutAttributeLeading
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeLeading
                      multiplier:1.0f
                      constant:10.0f];
        [self addConstraint:constraint];
        
        
        
        [self addSubview:self.recordButton];
        
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.recordButton
                      attribute:NSLayoutAttributeBottom
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeBottom
                      multiplier:1.0f
                      constant:-10.0f];
        [self addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.recordButton
                      attribute:NSLayoutAttributeCenterX
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeCenterX
                      multiplier:1.0f
                      constant:0.0f];
        [self addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.recordButton
                      attribute:NSLayoutAttributeWidth
                      relatedBy:NSLayoutRelationEqual
                      toItem:nil
                      attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:1.0f
                      constant:60.0f];
        [self addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.recordButton
                      attribute:NSLayoutAttributeHeight
                      relatedBy:NSLayoutRelationEqual
                      toItem:nil
                      attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:1.0f
                      constant:60.0f];
        [self addConstraint:constraint];
        
        
        [self addSubview:self.actionButton];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.actionButton
                      attribute:NSLayoutAttributeTop
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeTop
                      multiplier:1.0f
                      constant:10.0f];
        [self addConstraint:constraint];
        
        constraint = [NSLayoutConstraint
                      constraintWithItem:self.actionButton
                      attribute:NSLayoutAttributeTrailing
                      relatedBy:NSLayoutRelationEqual
                      toItem:self
                      attribute:NSLayoutAttributeTrailing
                      multiplier:1.0f
                      constant:-10.0f];
        [self addConstraint:constraint];
    }
    [self addSubview:self.filterButton];
    self.filterButton.layer.zPosition = MAXFLOAT;
    self.filterButton.hidden = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Add)];
    [self.filterButton addGestureRecognizer:tap];
    
    return self;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_backButton setImage:[UIImage imageNamed:@"return_icon"] forState:UIControlStateNormal];
        _backButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backButton;
}

- (UIButton *)recordButton
{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _recordButton.layer.cornerRadius = 60.0f/2.0;
        _recordButton.backgroundColor = [UIColor whiteColor];
        _recordButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _recordButton;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_actionButton setImage:[UIImage imageNamed:@"icon_action"] forState:UIControlStateNormal];
        _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _actionButton;
}

- (UIButton *)filterButton
{
    if (!_filterButton) {
        _filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _filterButton.frame = CGRectMake(300, 300, 100, 100);
        [_filterButton setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
//        _filterButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _filterButton;
}




@end
