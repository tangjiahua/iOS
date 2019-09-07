//
//  ListViewController.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "ListViewController.h"
#import "MMLHomeViewController.h"
#import "MMLDemoItem.h"
#import "MMLCameraViewController.h"
#import "MMLSimpleCameraViewController.h"

NSString * const cellReuseIdentifier = @"SVListTableViewCell";

@interface ListViewController () <ShowCommentProtocal, writeComment>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NavigationLabel *navigationLabel;
@property (nonatomic, strong) NSMutableArray<ItemModel *> *items;
@property (nonatomic, strong) CommentListView *commentView;
@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"Image List";
    [self.view addSubview:self.tableView];
    
    _navigationLabel = [[NavigationLabel alloc] initWithHomeButtonClick:@selector(homeButtonClick) recButtonClick:@selector(recButtonClick) myButtonClick:@selector(myButtonClick) TargetObj:self];
    [self.view addSubview:_navigationLabel];
    
    [self reloadData];
    
    self.isActive = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.definesPresentationContext = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    [self didBecomeActive];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self didResignActive];
}

- (void)reloadData {
    [DataManager fetchVideoListWithCompletionBlock:^(NSArray<ItemModel *> * _Nullable result, NSError * _Nullable error) {
        if (result && !error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.items = result.mutableCopy;
                [self.tableView reloadData];
                [self playFirstVideo];
            });
        }
    }];
}

- (void)playFirstVideo {
    ListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell playVideo];
}

#pragma mark - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    [cell configWithModel:self.items[indexPath.row] forIndexPath:indexPath];
    cell.ShowCommentdelegate = self;
    cell.WriteCommentlegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[self activeCell] playVideo];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.items.count) {
        [(ListTableViewCell *)cell didEndDisplayModel:self.items[indexPath.row] forIndexPath:indexPath];
    }
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.pagingEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}

#pragma mark - UIViewController preferences
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Utils
- (ListTableViewCell *)activeCell {
    NSInteger page = round(self.tableView.contentOffset.y / self.view.bounds.size.height);
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
}

#pragma mark - Notifications
- (void)didResignActive {
    self.isActive = NO;
    [[self activeCell] pauseVideo];
}

- (void)didBecomeActive {
    self.isActive = YES;
    [[self activeCell] playVideo];
}

#pragma mark - Actions

-(void)homeButtonClick
{
    if (_navigationLabel.nowSelectButton != 1)
    {
        _navigationLabel.nowSelectButton = 1;
        [_navigationLabel.homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _navigationLabel.homeButton.layer.borderWidth = 2;
        _navigationLabel.homeButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [_navigationLabel.myButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _navigationLabel.myButton.layer.borderWidth = 0;
    }
}

- (void)recButtonClick
{
    //TODO: 滤镜
    
    //    CameraViewController *cameraView = [[CameraViewController alloc] init];
    //
    //    [self presentViewController:cameraView animated:YES completion:nil];
    MMLDemoItem *cameraDemo = [[MMLDemoItem alloc] init];
    cameraDemo.name = @"视频拍摄示例二";
    cameraDemo.detail = @"展示如何拍摄视频，并给视频帧加上滤镜";
    cameraDemo.clazz = [MMLCameraViewController class];
    
    MMLCameraViewController *viewContrller = [[cameraDemo.clazz alloc] init];
    
    [self presentViewController:viewContrller animated:YES completion:nil];
}

-(void)myButtonClick
{
    if (_navigationLabel.nowSelectButton != 3)
    {
        _navigationLabel.nowSelectButton = 3;
        [_navigationLabel.myButton setTitleColor:[UIColor whiteColor] forState:normal];
        _navigationLabel.myButton.layer.borderWidth = 2;
        _navigationLabel.myButton.layer.borderColor = [UIColor whiteColor].CGColor;

        [_navigationLabel.homeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _navigationLabel.homeButton.layer.borderWidth = 0;
    }
}

#pragma mark - ShowCommentProtocal

- (void)ShowCommentViewWithItem:(ItemModel *)item
{
    self.commentView = [[CommentListView alloc] initWithItem:item];
    
    [self.view addSubview:_commentView];
    CABasicAnimation *layin = [CABasicAnimation animationWithKeyPath:@"opacity"];
    layin.fromValue = @(0);
    layin.toValue = @(1);
    layin.duration = 0.2;
    layin.removedOnCompletion = NO;
    layin.fillMode = kCAFillModeBoth;
    [_commentView.layer addAnimation:layin forKey:nil];
    
}

#pragma mark - writeComment

- (void)writeCommentToItem:(ItemModel *)item
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入评论" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"评论";
    }];
    __weak typeof(alertController) weakAlertController = alertController;
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakAlertController) alertController = weakAlertController;
        __strong typeof(weakSelf) self = weakSelf;
        NSString *title = alertController.textFields.firstObject.text;
        if (!title.length) {
            title = @"No description";
        }
        NSString *newComment;
        if ([item.extra isEqualToString:@""]) {
            newComment = [NSString stringWithFormat:@"我@%@",title];
        }
        else newComment = [NSString stringWithFormat:@"%@#我@%@",item.extra,title];
        item.extra = newComment;
        [self onUpdateTaskClicked:[NSNumber numberWithInteger:item.videoId] andComment:newComment];
        [item refreshComment];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - update comment

//评论视频在这里
//comment需要是原extra加上新的评论组成的
- (void)onUpdateTaskClicked:(NSNumber *)video_id andComment:(NSString *)comment
{
    
    NSLog(@"onUpdateTaskClicked");
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.xiongdianpku.com/api/bytedance/video/update"]]];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSDictionary *dictM = @{
                            @"extra":comment,
                            @"video_id":video_id
                            };
    
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dictM options:kNilOptions error:nil];
    request.timeoutInterval = 10;
    
    
    //3 init task
    self.task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error || !data) {
            NSLog(@"Upload failed! Error: %@",error);
            return ;
        }
        else{
            NSLog(@"success");
            NSLog(@"%@",response);
        }
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([responseData[@"success"] boolValue]) {
            NSLog(@"%@",responseData[@"successInfo"]);
        } else {
            
        }
    }];
    //4- start the task
    [self.task resume];
}

@end
