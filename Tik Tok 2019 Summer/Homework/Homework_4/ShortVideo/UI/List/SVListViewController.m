//
//  SVListViewController.m
//  ShortVideo
//
//  Created by ByteDance on 2019/7/8.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "SVListViewController.h"

@interface SVListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINavigationBar *navigator;
@property (nonatomic, copy) NSArray<ImageModel *> *dataArray;

@end

@implementation SVListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [@[
                        [ImageDataProvider sharedProvider].MojaveModel,
                        [ImageDataProvider sharedProvider].SierraModel,
                        [ImageDataProvider sharedProvider].CatalinaModel,
                        [ImageDataProvider sharedProvider].YosemiteModel,
                        [ImageDataProvider sharedProvider].ElCapitanModel,
                        [ImageDataProvider sharedProvider].HighSierraModel,
                        ] copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;//???????????????????????????????????????????????????????????????????????????????????????????
    [self.view addSubview:self.tableView];
    
    
//    _navigator = [[UINavigationBar alloc]init];
//    _navigator.topItem.title = @"List";
    self.navigationItem.title = @"List";
    [self.view addSubview:self.navigator];
    
//    UIImage * icon = [UIImage imageNamed:@"goods_1"];
//    CGSize itemSize = CGSizeMake(36, 36);//固定图片大小为36*36
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
//    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
//    [icon drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
//    UIGraphicsEndImageContext();//*3
}


#pragma DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    ImageModel *nowImage = _dataArray[indexPath.row];
//    cell.imageView.image = nowImage.image;
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.textLabel.text = nowImage.imageTitle;
    
    
    
    UIImage * icon = _dataArray[indexPath.row].image;
    CGSize itemSize = CGSizeMake(36, 36);//固定图片大小为36*36
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
    UIGraphicsEndImageContext();//*3
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageModel *nowModel = self.dataArray[indexPath.row];
    DetailViewController *nextView = [[DetailViewController alloc] initWithModel:nowModel];
    [self.navigationController pushViewController:nextView animated:YES];
    
}

@end

