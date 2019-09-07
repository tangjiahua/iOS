//
//  BITViewController.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/11.
//  Copyright © 2019 ByteDance. All rights reserved.


#import "BITViewController.h"
#import "UIView+BITAddtions.h"
#import "BITFilmDataProvider.h"
#import "BITFilmDetailViewController.h"

@interface BITViewController ()

@property (nonatomic, strong) BITFilmModel *filmModel;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *checkDetailButton;//详情按钮

@end

@implementation BITViewController

- (void)dealloc {
    // 取消KVO
}

- (instancetype)initWithFilmModel:(BITFilmModel *)filmModel {
    self = [super init];
    if (self) {
        _filmModel = filmModel;

        // 配置tabBarItem
        self.tabBarItem.title = filmModel.filmName;
        self.tabBarItem.image = [UIImage imageNamed:filmModel.filmIcon];
        self.tabBarItem.badgeValue = @"99";
        // 配置navigationItem —— title
        self.navigationItem.title = filmModel.filmName;
        // 添加KVO
        [self addObserver:self forKeyPath:@"filmModel.isFavorite" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

// 添加生命周期方法
// Log打印可以参考： NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {

    self.view.backgroundColor = [UIColor whiteColor];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bit_width, self.view.bit_height)];
    self.imageView.image = [UIImage imageNamed:self.filmModel.imageName];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
    // 为imageView添加双击手势,双击交给doubleTapped方法去执行，

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
    tapGesture.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tapGesture];

    [self.view addSubview:self.imageView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bit_height - 150, self.view.bit_width, 100)];
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.font = [UIFont systemFontOfSize:30];
    
    //喜欢的时候在filmname后添加小红心
    NSString *title = nil;
    if(self.filmModel.isFavorite){
        title = [NSString stringWithFormat:@"%@❤️", self.filmModel.filmName];
    }else
    {
        title = self.filmModel.filmName;
    }
    self.titleLabel.text = title;

//    self.titleLabel.text = self.filmModel.filmName;
    [self.view addSubview:self.titleLabel];

    self.checkDetailButton = [[UIButton alloc] init];
    self.checkDetailButton.bit_width = 100;
    self.checkDetailButton.bit_right = self.view.bit_right - 20;
    self.checkDetailButton.bit_height = 44;
    self.checkDetailButton.bit_centerY = self.titleLabel.bit_centerY;
    [self.checkDetailButton addTarget:self action:@selector(checkDetailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkDetailButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.checkDetailButton setTitle:@"详情" forState:UIControlStateNormal];
    [self.checkDetailButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:self.checkDetailButton];

}

#pragma mark - action

// 添加双击手势处理函数
- (void)doubleTapped {
    self.filmModel.isFavorite = !self.filmModel.isFavorite;
}

// 添加跳转详情页按钮点击函数
- (void)checkDetailButtonClicked:(UIButton *)button {
    self.navigationItem.title = _filmModel.filmName;
    BITFilmDetailViewController *detailViewCOntroller = [[BITFilmDetailViewController alloc] init];
    detailViewCOntroller.filmModel = self.filmModel;
    [self.navigationController pushViewController:detailViewCOntroller animated:YES];
}

#pragma mark - KVO

// 添加KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"filmModel.isFavorite"]){
        //BOOL isFavorite = [change[NSKeyValueChangeNewKey] boolValue];
        NSString *title = nil;
        if(self.filmModel.isFavorite){
            title = [NSString stringWithFormat:@"%@❤️", self.filmModel.filmName];
        }else
        {
            title = self.filmModel.filmName;
        }
        self.titleLabel.text = title;
    }
}
// 添加资源释放逻辑
- (void)didReceiveMemoryWarning {

}

@end
//#import "BITViewController.h"
//#import "UIView+BITAddtions.h"
//#import "BITFilmDataProvider.h"
//#import "BITFilmDetailViewController.h"
//
//@interface BITViewController ()
//@property (nonatomic, strong) BITFilmModel *filmModel;
//
//@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *checkDetailButton;
//
//@end
//
//@implementation BITViewController
//
//- (void)dealloc {
//    [self removeObserver:self forKeyPath:@"filmModel.isFavorite"];
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//
//- (instancetype)initWithFilmModel:(BITFilmModel *)filmModel {
//    self = [super init];
//    if (self) {
//        _filmModel = filmModel;
//        self.tabBarItem.title = filmModel.filmName;
//        self.tabBarItem.image = [UIImage imageNamed:filmModel.filmIcon];
//
//        self.navigationItem.title = filmModel.filmName;
//
//        [self addObserver:self forKeyPath:@"filmModel.isFavorite" options:NSKeyValueObservingOptionNew context:nil];
//
//        NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//    }
//    return self;
//}
//
//- (void)loadView {
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//    return [super loadView];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self setupUI];
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    NSLog(@"【%@】%@ ---- called", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//}
//
//- (void)setupUI {
//
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bit_width, self.view.bit_height)];
//    self.imageView.image = [UIImage imageNamed:self.filmModel.imageName];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped:)];
//    tapGesture.numberOfTapsRequired = 2;
//    [self.imageView addGestureRecognizer:tapGesture];
//    [self.view addSubview:self.imageView];
//
//
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bit_height - 150, self.view.bit_width, 100)];
//    self.titleLabel.textColor = [UIColor redColor];
//    self.titleLabel.font = [UIFont systemFontOfSize:30];
//    self.titleLabel.text = self.filmModel.filmName;
//    [self.view addSubview:self.titleLabel];
//
//    self.checkDetailButton = [[UIButton alloc] init];
//    self.checkDetailButton.bit_width = 100;
//    self.checkDetailButton.bit_right = self.view.bit_right - 20;
//    self.checkDetailButton.bit_height = 44;
//    self.checkDetailButton.bit_centerY = self.titleLabel.bit_centerY;
//    [self.checkDetailButton addTarget:self action:@selector(checkDetailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.checkDetailButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [self.checkDetailButton setTitle:@"详情" forState:UIControlStateNormal];
//    [self.checkDetailButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
//    [self.view addSubview:self.checkDetailButton];
//}
//
//#pragma mark - actions
//
//- (void)imageViewTaped:(UITapGestureRecognizer *)tapgesture {
//    self.filmModel.isFavorite = !self.filmModel.isFavorite;
//}
//
//- (void)checkDetailButtonClicked:(UIButton *)button {
//    BITFilmDetailViewController *detailViewController = [[BITFilmDetailViewController alloc] init];
//    detailViewController.filmModel = self.filmModel;
//    [self.navigationController pushViewController:detailViewController animated:YES];
//}
//
//
//#pragma mark - KVO
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//
//    if ([keyPath isEqualToString:@"filmModel.isFavorite"]) {
//        BOOL isFavorite = [change[NSKeyValueChangeNewKey] boolValue];
//        NSString *title = nil;
//        if (isFavorite) {
//            title = [NSString stringWithFormat:@"%@ ❤", self.filmModel.filmName];
//        } else {
//            title = self.filmModel.filmName;
//        }
//        self.titleLabel.text = title;
//    }
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    if (self.isViewLoaded && self.view.window == nil) {
//        self.view = nil;
//    }
//}
//
//@end
