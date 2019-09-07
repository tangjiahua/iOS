//
//  MMLHomeViewController.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/6/25.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLHomeViewController.h"
#import "MMLDemoItem.h"
#import "MMLCameraViewController.h"
#import "MMLSimpleCameraViewController.h"

@interface MMLHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<MMLDemoItem *> *dataSource;

@end

@implementation MMLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    MMLDemoItem *simpleCameraDemo = [[MMLDemoItem alloc] init];
    simpleCameraDemo.name = @"视频拍摄示例一";
    simpleCameraDemo.detail = @"展示如何拍摄视频";
    simpleCameraDemo.clazz = [MMLSimpleCameraViewController class];
    
    MMLDemoItem *cameraDemo = [[MMLDemoItem alloc] init];
    cameraDemo.name = @"视频拍摄示例二";
    cameraDemo.detail = @"展示如何拍摄视频，并给视频帧加上滤镜";
    cameraDemo.clazz = [MMLCameraViewController class];
    
    self.dataSource = @[simpleCameraDemo,cameraDemo];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    MMLDemoItem *item = self.dataSource[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.detail;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMLDemoItem *item = self.dataSource[indexPath.row];
    UIViewController *viewContrller = [[item.clazz alloc] init];
    
    if ([viewContrller isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:viewContrller animated:YES];
    }
}

@end
