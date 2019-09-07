//
//  BITTableViewController.m
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/14.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "BITTableViewController.h"
#import "BITTableViewCell.h"
#import "BITFilmDataProvider.h"
#import "BITFilmDetailViewController.h"
#import "UIView+BITAddtions.h"


@interface BITFilmDetailViewController ()

// 遵守tableView的DataSource及delegate协议
@end

@interface BITTableViewController ()
@property (nonatomic, strong) UIButton *checkDetailButton;//详情按钮
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *modelArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BITFilmModel *filmModel;
@end

@implementation BITTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _modelArray = [@[
                         [BITFilmDataProvider sharedProvider].avengersModel,
                         [BITFilmDataProvider sharedProvider].aquamanModel,
                         [BITFilmDataProvider sharedProvider].ironManModel,
                         [BITFilmDataProvider sharedProvider].captainAmericaModel,
                         ] copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {

    self.view.backgroundColor = [UIColor whiteColor];

    // 创建UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    // 注册可复用Cell类型
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

    
    [self.view addSubview:self.tableView];
    
    self.checkDetailButton = [[UIButton alloc] init];
    self.checkDetailButton.bit_width = 100;
    self.checkDetailButton.bit_centerX =80;
    self.checkDetailButton.bit_height = 44;
    self.checkDetailButton.bit_centerY = 80;
    [self.checkDetailButton addTarget:self action:@selector(checkDetailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkDetailButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.checkDetailButton setTitle:@"详情" forState:UIControlStateNormal];
    [self.checkDetailButton.titleLabel setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:self.checkDetailButton];
}


- (void)checkDetailButtonClicked:(UIButton *)button {
    self.navigationItem.title = _filmModel.filmName;
    BITFilmDetailViewController *detailViewCOntroller = [[BITFilmDetailViewController alloc] init];
    detailViewCOntroller.filmModel = self.filmModel;
    [self.navigationController pushViewController:detailViewCOntroller animated:YES];
}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsIntableView:(UITableView*)tableView{
    return 1;
}

// UITableViewDataSource两个必须实现的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 //   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    BITFilmModel *model = [self.modelArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.filmName;
    cell.imageView.image = [UIImage imageNamed:model.filmIcon];
    return cell;
}

#pragma mark - UITableViewDelegate

// 为每个cell返回不同的高度

// 处理用户的选中事件

@end
