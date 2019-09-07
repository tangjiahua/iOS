//
//  BITScrollViewViewController.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/14.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "BITScrollViewViewController.h"

// 遵守scrollView的delegate
@interface BITScrollViewViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation BITScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    // 计算Disney.jpg图片的显示大小
    UIImage *image = [UIImage imageNamed:@"Disney.jpg"];
    CGFloat imageWidth = image.size.width / [UIScreen mainScreen].scale;
    CGFloat imageHeight = image.size.height / [UIScreen mainScreen].scale;
    
        self.scrollView.pagingEnabled = YES;
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    // 设置scrollView的contentSize
    scrollView.contentSize = CGSizeMake(imageWidth, imageHeight);
    // 向scrollView添加子视图
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    self.imageView.image = [UIImage imageNamed:@"Disney.jpg"];
    [scrollView addSubview:self.imageView];
    // 体会一下pagingEnabled属性的作用

    // zoom

    // 将scrollView添加到视图控制器的根视图上
    [self.view addSubview:scrollView];
}

#pragma mark - UIScrollViewDelegate

@end
