//
//  ItemModel.h
//  Test
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

//@property (nonatomic, assign) NSInteger videoId;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *coverURL;
//@property (nonatomic, strong) NSString *videoURL;
//@property (nonatomic, assign) BOOL deletable;

@property (nonatomic, assign) NSInteger videoId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *coverURL;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, assign) BOOL deletable;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, strong) NSString *extra;
@property (nonatomic, strong) NSMutableArray<NSString *> *who;
@property (nonatomic, strong) NSMutableArray<NSString *> *saidwhat;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
