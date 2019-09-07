//
//  CommentModel.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithName:(NSString *)name Comment:(NSString *)comment
{
    self = [super init];
    if (self) {
        self.name = name;
        self.comment = comment;
        [self cellHeight];
    }
    return self;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight = ( 17 + 14 + 7 + 12.5 + 14 + 17 + [self.comment boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 14 -14 -14 -34, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height);
    }
    return _cellHeight;
}

@end
