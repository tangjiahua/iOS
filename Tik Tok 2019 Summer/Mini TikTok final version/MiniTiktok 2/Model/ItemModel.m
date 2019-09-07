//
//  ItemModel.m
//  Test
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

//- (instancetype)initWithDict:(NSDictionary *)dict {
//    self = [super init];
//    if (self) {
//        self.videoId = [dict[@"video_id"] integerValue];
//        self.title = dict[@"title"];
//        self.coverURL = dict[@"cover_url"];
//        self.videoURL = dict[@"video_url"];
//        self.deletable = [dict[@"deletable"] boolValue];
//    }
//    return self;
//}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.videoId = [dict[@"video_id"] integerValue];
        self.title = dict[@"title"];
        self.coverURL = dict[@"cover_url"];
        self.videoURL = dict[@"video_url"];
        self.deletable = [dict[@"deletable"] boolValue];
        self.extra = dict[@"extra"];
        if (self.extra == NULL || [self.extra isEqual:[NSNull null]])
        {
            self.extra = @"";
        }
//        self.extra = @"杨福浩@我觉得视频很好看#汤佳桦@我也觉得#王子淳@嗯嗯同意#胡启航@只有我一个人觉得很无聊吗？？？";
        self.who = [[NSMutableArray alloc] init];
        self.saidwhat = [[NSMutableArray alloc] init];
        [self refreshComment];
    }
    return self;
}

-(void) refreshComment
{
    [_who removeAllObjects];
    [_saidwhat removeAllObjects];

    NSArray<NSString *> *PiecesOfComment = [[NSArray alloc] initWithArray:[_extra componentsSeparatedByString:@"#"]];
    for (NSString *data in PiecesOfComment)
    {
        NSArray<NSString *> *aPieceOfComment = [data componentsSeparatedByString:@"@"];
        if (aPieceOfComment.count != 2) {
            self.extra = @"";
            return;
        }
        [_who addObject:aPieceOfComment[0]];
        [_saidwhat addObject:aPieceOfComment[1]];
    }
}

@end