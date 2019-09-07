//
//  CommentListViewController.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "CommentListView.h"

NSInteger ViewHeight;
NSInteger ViewWidth;

@interface CommentListView ()<UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) ItemModel *item;

@end

@implementation CommentListView

- (instancetype)initWithItem:(ItemModel *)item
{
    ViewHeight = CGRectGetHeight([UIScreen mainScreen].bounds) * 3 / 5;
    ViewWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    self = [super init];
    if (self) {
        self.item = item;
        [self setFrame:UIScreen.mainScreen.bounds];
        
        self.returnButton = [[UIButton alloc] initWithFrame:UIScreen.mainScreen.bounds];
        [_returnButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnButton];
        
        CGRect blurFrame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen.bounds) - ViewHeight, ViewWidth, ViewHeight);
        
        UIVisualEffectView *blur = [[UIVisualEffectView alloc] initWithFrame:blurFrame];
        blur.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        [self addSubview:blur];
        
        CGFloat naviBarHeight = 30;
        CGFloat totalLabelHeight = 15;//与字体同步
        UILabel *totalNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, blurFrame.origin.y + naviBarHeight - totalLabelHeight, CGRectGetWidth(blurFrame), totalLabelHeight)];
        [totalNumberLabel setFont:[UIFont systemFontOfSize:totalLabelHeight]];
        totalNumberLabel.textColor = [UIColor whiteColor];
        [totalNumberLabel setText:[NSString stringWithFormat:@"%lu 条评论",(unsigned long)item.who.count]];
        [totalNumberLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:totalNumberLabel];
        
        CGRect tableViewFrame = CGRectMake(0, blurFrame.origin.y + naviBarHeight, blurFrame.size.width, blurFrame.size.height - naviBarHeight);
        
        UITableView *commentTableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        commentTableView.backgroundColor = [UIColor clearColor];
        commentTableView.delegate = self;
        commentTableView.dataSource = self;
        
        [self addSubview:commentTableView];
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.item.who.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    NSString *whoSaidThat = [NSString stringWithFormat:@"%@说：",self.item.who[indexPath.row]];
    NSString *saidWhat = [NSString stringWithFormat:@"    %@",self.item.saidwhat[indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setText:whoSaidThat];
    [cell.detailTextLabel setText:saidWhat];
    
    return cell;
}

#pragma mark - Button Actions

-(void) buttonClick
{
    CABasicAnimation *layout = [CABasicAnimation animationWithKeyPath:@"opacity"];
    layout.fromValue = @(1);
    layout.toValue = @(0);
    layout.duration = 0.2;
    layout.removedOnCompletion = NO;
    layout.fillMode = kCAFillModeForwards;
    layout.delegate = self;
    [layout setValue:@"out" forKey:@"ani"];
    [self.layer addAnimation:layout forKey:@"out"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        if ([[anim valueForKey:@"ani"] isEqualToString:@"out"]) {
            [self removeFromSuperview];
        }
    }
}

@end
