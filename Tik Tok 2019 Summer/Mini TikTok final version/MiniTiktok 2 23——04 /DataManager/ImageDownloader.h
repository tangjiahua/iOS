//
//  ImageDownloader.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : NSObject

+ (void)downloadImageFromURLString:(NSString *)urlString
                           taskTag:(NSString *)tag
                   completionBlock:(void (^)(UIImage * _Nullable image, NSError * _Nullable error))completionBlock;

+ (void)cancelDownloadingFromURLString:(NSString *)urlString
                            forTaskTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
