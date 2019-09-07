//
//  CommentTableViewCell.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell ()

@property (nonatomic, strong) CommentModel *commentItem;

@end

@implementation CommentTableViewCell

- (instancetype)initWithItem:(CommentModel *)item
{
    self = [super init];
    if (self) {
        self.commentItem = item;
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
