//
//  ImageDownloader.m
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloadTask : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *completionBlocks;
@property (nonatomic, strong) UIImage *cachedImage;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation ImageDownloadTask

@end

static NSMutableDictionary<NSString *, ImageDownloadTask *> *imageDownloaderTasks;

@implementation ImageDownloader

+ (void)downloadImageFromURLString:(NSString *)urlString
                           taskTag:(nonnull NSString *)tag
                   completionBlock:(nonnull void (^)(UIImage * _Nullable, NSError * _Nullable))completionBlock {
    
    if (urlString.length == 0) {
        return;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageDownloaderTasks = [NSMutableDictionary dictionary];
    });
    
    if (imageDownloaderTasks[urlString].cachedImage) {
        completionBlock(imageDownloaderTasks[urlString].cachedImage, nil);
        return;
    } else if (imageDownloaderTasks[urlString]) {
        imageDownloaderTasks[urlString].completionBlocks[tag] = completionBlock;
        return;
    }
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *responseError = error;
        UIImage *responseImage = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageDownloaderTasks[urlString].cachedImage = responseImage;
            [imageDownloaderTasks[urlString].completionBlocks enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, void (^ _Nonnull obj)(UIImage *image, NSError *error), BOOL * _Nonnull stop) {
                obj(responseImage, responseError);
            }];
            [imageDownloaderTasks[urlString].completionBlocks removeAllObjects];
            imageDownloaderTasks[urlString].dataTask = nil;
        });
    }];
    
    ImageDownloadTask *task = [[ImageDownloadTask alloc] init];
    task.dataTask = dataTask;
    task.completionBlocks = [NSMutableDictionary dictionaryWithObjectsAndKeys:completionBlock, tag, nil];
    
    imageDownloaderTasks[urlString] = task;
    [dataTask resume];
}

+ (void)cancelDownloadingFromURLString:(NSString *)urlString forTaskTag:(NSString *)tag {
    [imageDownloaderTasks[urlString].completionBlocks removeObjectForKey:tag];
    if (imageDownloaderTasks[urlString].completionBlocks.count == 0 && imageDownloaderTasks[urlString].dataTask) {
        [imageDownloaderTasks[urlString].dataTask cancel];
        imageDownloaderTasks[urlString] = nil;
    }
}

@end
