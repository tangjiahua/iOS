//
//  MMLCameraInteractionView.h
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/16.
//  Copyright © 2019 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMLCameraInteractionView : UIView

@property (nonatomic, strong, readonly) UIButton *backButton;
@property (nonatomic, strong, readonly) UIButton *recordButton;
@property (nonatomic, strong, readonly) UIButton *actionButton;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

- (NSInteger)Add;

@end

NS_ASSUME_NONNULL_END
