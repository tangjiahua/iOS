//
//  DataManager.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Model/ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

+ (void)fetchVideoListWithCompletionBlock:(void (^)(NSArray<ItemModel *> * _Nullable result, NSError * _Nullable error))completionBlock;

+ (void)uploadVideoFromURL:(NSURL *)url withTitle:(NSString *)title completionBlock:(void (^)(ItemModel * _Nullable result, NSError * _Nullable error))completionBlock;

+ (void)deleteVideo:(ItemModel *)model withCompletionBlock:(void (^)(BOOL success, NSError * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
