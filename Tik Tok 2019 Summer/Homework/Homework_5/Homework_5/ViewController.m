//
//  ViewController.m
//  Homework_5
//
//  Created by 汤佳桦 on 2019/7/16.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import "ViewController.h"
#import "staticCircle.h"
#import "staticCircle_.h"

#define WIDTH 50
@interface ViewController ()
@property (nonatomic, strong) UIView *circle;
@property (nonatomic, strong) UIView *circle2;
@property (nonatomic, strong) UIView *circle_;
@property (nonatomic, strong) UIView *circle2_;



@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self.view addSubview: self.circle];
    [self circle_];
    [self circle2_];
    [self.view addSubview: self.circle];
    [self.view addSubview: self.circle2];
    
    

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _circle_.bounds;
    gradient.endPoint = CGPointMake(0.5, 1);
    gradient.startPoint = CGPointMake(0.5, 0);
    gradient.colors = @[(id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
    gradient.locations = @[@(0), @(0.35), @(1)];
    _circle_.layer.mask = gradient;
    [self.view addSubview: self.circle_];
    CAGradientLayer *gradient2 = [CAGradientLayer layer];
    gradient2.frame = _circle_.bounds;
    gradient2.endPoint = CGPointMake(0.5, 1);
    gradient2.startPoint = CGPointMake(0.5, 0);
    gradient2.colors = @[(id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
    gradient2.locations = @[@(0), @(0.35), @(1)];
    _circle_.layer.mask = gradient;
    _circle2_.layer.mask = gradient2;

    [self.view addSubview: self.circle2_];
    [self.view addSubview: [[staticCircle alloc]init]];
    
    [self rotateAnimation];
    [self moveAnimation];
    [self createReflection];
    //[self startAnimating];
    
}

- (void)rotateAnimation
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(0.4 * M_PI);
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotateAnimation.duration = 0.5;
    rotateAnimation.autoreverses = 1;
    rotateAnimation.repeatCount = 1;
    //rotateAnimation.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self rotateAnimation2];
     });
    [self.circle.layer addAnimation:rotateAnimation forKey:nil];
    
}
- (void)rotateAnimation2
{
    
        CABasicAnimation *rotateAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnimation2.fromValue = @(0);
        rotateAnimation2.toValue = @(-0.4 * M_PI);
        rotateAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotateAnimation2.duration = 0.5;
        rotateAnimation2.autoreverses = 1;
        rotateAnimation2.repeatCount = 1;
        //rotateAnimation.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self rotateAnimation];
    });
        [self.circle2.layer addAnimation:rotateAnimation2 forKey:nil];
  
}
- (void)moveAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.fromValue = @(_circle_.center.x);
    moveAnimation.toValue = @(_circle_.center.x - 75*sin(0.4*M_PI));
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation.duration = 0.5;
    moveAnimation.autoreverses = 1;
    moveAnimation.repeatCount = 1;
    //rotateAnimation.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveAnimation2];
    });
    [self.circle_.layer addAnimation:moveAnimation forKey:nil];
    
}
- (void)moveAnimation2
{
    
    CABasicAnimation *moveAnimation2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation2.fromValue = @(_circle2_.center.x);
    moveAnimation2.toValue = @(_circle2_.center.x + 75*sin(0.4*M_PI));
    moveAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    moveAnimation2.duration = 0.5;
    moveAnimation2.autoreverses = 1;
    moveAnimation2.repeatCount = 1;
    //rotateAnimation.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveAnimation];
    });
    [self.circle2_.layer addAnimation:moveAnimation2 forKey:nil];
    
}
- (UIView *)circle
{
    //(70,200)
    if (!_circle) {
        _circle = [[UIView alloc] initWithFrame:CGRectMake(65, 200, WIDTH, WIDTH)];
                _circle.layer.anchorPoint = CGPointMake(0.5, -1);        // 5. 锚点改变
        _circle.layer.cornerRadius = WIDTH / 2;
        _circle.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];
        //_circle.layer.backgroundColor = @[(id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
    }
    return _circle;
}
- (UIView *)circle2
{
    if (!_circle2) {
        _circle2 = [[UIView alloc] initWithFrame:CGRectMake(65+5*50, 200, WIDTH, WIDTH)];
        _circle2.layer.anchorPoint = CGPointMake(0.5, -1);        // 5. 锚点改变
        _circle2.layer.cornerRadius = WIDTH / 2;
        _circle2.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];
        
    }
    return _circle2;
}

- (UIView *)circle_
{
    //(70,200)
    if (!_circle_) {
        _circle_ = [[UIView alloc] initWithFrame:CGRectMake(65, 400, WIDTH, WIDTH)];
        _circle_.layer.anchorPoint = CGPointMake(0.5, 2);        // 5. 锚点改变
        _circle_.layer.cornerRadius = WIDTH / 2;
        _circle_.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];
        //_circle.layer.backgroundColor = @[(id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, (id)[UIColor clearColor].CGColor, (id)[UIColor clearColor].CGColor];
    }
    return _circle_;
}
- (UIView *)circle2_
{
    if (!_circle2_) {
        _circle2_ = [[UIView alloc] initWithFrame:CGRectMake(65+5*50, 400, WIDTH, WIDTH)];
        _circle2_.layer.anchorPoint = CGPointMake(0.5, 2);        // 5. 锚点改变
        _circle2_.layer.cornerRadius = WIDTH / 2;
        _circle2_.backgroundColor = [UIColor colorWithRed:0 green:0.63 blue:1 alpha:1];
        
    }
    return _circle2_;
}

- (void)createReflection
{
    [self.view addSubview: [[staticCircle_ alloc]init]];
    
    [self rotateAnimation];
}

@end

