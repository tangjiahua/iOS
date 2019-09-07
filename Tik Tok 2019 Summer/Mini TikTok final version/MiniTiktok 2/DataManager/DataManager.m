//
//  DataManager.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (void)fetchVideoListWithCompletionBlock:(void (^)(NSArray<ItemModel *> * _Nullable, NSError * _Nullable))completionBlock
{
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    [[sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://www.xiongdianpku.com/api/bytedance/video/list"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *responseData = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
        if ([responseData[@"success"] boolValue]) {
            NSMutableArray *responseModels = [NSMutableArray array];
            [responseData[@"successInfo"] enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ItemModel *itemModel = [[ItemModel alloc] initWithDict:obj];
                if (![itemModel.title isEqualToString:@"video_upload_demo"]) {
                    [responseModels addObject:itemModel];
                }
            }];
            completionBlock(responseModels.copy, nil);
        } else {
            completionBlock(nil, error ?: [NSError errorWithDomain:@"SVDataManagerErrorDomain" code:1 userInfo: @{NSLocalizedDescriptionKey: responseData[@"errorInfo"] ?: @"Unknown Error"}]);
        }
    }] resume];
}

+ (void)uploadVideoFromURL:(NSURL *)url
                 withTitle:(NSString *)title
           completionBlock:(void (^)(ItemModel * _Nullable, NSError * _Nullable))completionBlock {
    // Demo 1-3 上传视频
}

+ (void)deleteVideo:(ItemModel *)model withCompletionBlock:(void (^)(BOOL, NSError * _Nullable))completionBlock {
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.xiongdianpku.com/api/bytedance/videp/detail/%ld", model.videoId]]];
    request.HTTPMethod = @"DELETE";
    [[sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([responseData[@"success"] boolValue]) {
            completionBlock(YES, nil);
        } else {
            completionBlock(NO, error ?: [NSError errorWithDomain:@"SVDataManagerErrorDomain" code:1 userInfo: @{NSLocalizedDescriptionKey: responseData[@"errorInfo"] ?: @"Unknown Error"}]);
        }
    }] resume];
}

@end
