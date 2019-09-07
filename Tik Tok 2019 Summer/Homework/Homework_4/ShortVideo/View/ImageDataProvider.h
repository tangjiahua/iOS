//
//  ImageDataProvider.h
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageDataProvider : NSObject

+ (instancetype) sharedProvider;

@property (nonatomic, strong) ImageModel *CatalinaModel;
@property (nonatomic, strong) ImageModel *ElCapitanModel;
@property (nonatomic, strong) ImageModel *HighSierraModel;
@property (nonatomic, strong) ImageModel *MojaveModel;
@property (nonatomic, strong) ImageModel *SierraModel;
@property (nonatomic, strong) ImageModel *YosemiteModel;

@end

NS_ASSUME_NONNULL_END
