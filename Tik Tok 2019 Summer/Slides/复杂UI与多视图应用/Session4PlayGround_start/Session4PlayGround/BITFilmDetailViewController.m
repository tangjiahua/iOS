//
//  BITFilmDetailViewController.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "BITFilmDetailViewController.h"
#import "UIView+BITAddtions.h"

@interface BITFilmDetailViewController ()

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation BITFilmDetailViewController

- (void)dealloc {
    // 取消KVO
    //[self removeObserver:self forKeyPath:@"filModel.isFavorite"];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 详细配置navigationItem -- title，rightBarButtonItem，rightBarButtonItems，backBarItem
        self.navigationItem.title = self.filmModel.filmName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(favoriteButtonClicked)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    // 根据model修改UI状态，descriptionLabel，navigationItem，返回按钮
    self.descriptionLabel.text = self.filmModel.filmDescription;
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.descriptionLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.descriptionLabel.numberOfLines = 0;
    [self.view addSubview:self.descriptionLabel];
    
    self.backButton = [[UIButton alloc] init];
    self.backButton.bit_left = 0;
    self.backButton.bit_top = 0;
    self.backButton.bit_height = 44;
    self.backButton.bit_width = 44;
    [self.backButton addTarget:self action:@selector(backbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.backButton setTitle:@"X" forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:self.backButton];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
#pragma mark - setter

// setter & add kvo

#pragma mark - actions

// 取消喜欢按钮点击事件
- (void)cancelFavoriteButtonClicked {
    self.filmModel.isFavorite = YES;
}

// 返回按钮点击事件
- (void)backbuttonClicked:(UIButton *)backButton {
    
}

- (void)favoriteButtonClicked {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.filmModel.filmName;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = self.filmModel.filmDescription;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    if (section == 0) {
        headerView.textLabel.text = @"电影名";
    } else {
        headerView.textLabel.text = @"剧情简介";
    }
    return headerView;
}
// 喜欢按钮点击事件
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    } else if (indexPath.section == 1) {
        return 400;
    }
    return 44;
}

#pragma mark - KVO

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"filmModel.isFavorite"]) {
        BOOL isFavorite = [change[NSKeyValueChangeNewKey] boolValue];
        NSString *imageName = isFavorite ? @"icon_like" : @"icon_like_normal";
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:imageName];
    }
}

#pragma mark - status bar display



- (BOOL)prefersStatusBarHidden {
    return self.presentingViewController;
}

@end
