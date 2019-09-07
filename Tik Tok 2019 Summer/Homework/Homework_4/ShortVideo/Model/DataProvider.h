//
//  DataProvider.h
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModelCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface DataProvider : NSObject

@property (nonatomic, strong) CellModelCollectionViewCell *Catalina;
@property (nonatomic, strong) CellModelCollectionViewCell *Sierra;
+ (instancetype)sharedProvider;

@end

NS_ASSUME_NONNULL_END
