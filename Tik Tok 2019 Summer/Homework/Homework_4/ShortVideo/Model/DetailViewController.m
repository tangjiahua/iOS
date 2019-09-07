//
//  DetailViewController.m
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()



@property (nonatomic, strong) ImageModel *nowModel;

@end


@implementation DetailViewController

- (instancetype)initWithModel:(ImageModel *)model
{
    self = [super init];
    if (self) {
        _nowModel = model;
        self.navigationItem.title = _nowModel.imageTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_nowModel.image];
    self.view.backgroundColor = [UIColor whiteColor];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
    
}

@end
