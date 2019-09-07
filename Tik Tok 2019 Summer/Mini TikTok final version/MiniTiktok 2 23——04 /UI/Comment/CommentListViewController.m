//
//  CommentListViewController.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "CommentListViewController.h"

@interface CommentListViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic,strong) NSMutableArray<ItemModel *> *commentItems;

@end

@implementation CommentListViewController

- (instancetype)initWithItems:(NSArray<ItemModel *> *)items
{
    self = [super init];
    if (self) {
        self.commentItems = [[NSMutableArray alloc] init];
        for (ItemModel *itm in items) {
            
        }
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Getters

#pragma mark - ButtonActions

@end
