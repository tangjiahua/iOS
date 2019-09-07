//
//  BITFilmDataProvider.h
//  Session4PlayGround
//
//  Created by Me55a on 2019/7/13.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BITFilmModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BITFilmDataProvider : NSObject

+ (instancetype)sharedProvider;

@property (nonatomic, strong) BITFilmModel *avengersModel;
@property (nonatomic, strong) BITFilmModel *aquamanModel;
@property (nonatomic, strong) BITFilmModel *ironManModel;
@property (nonatomic, strong) BITFilmModel *captainAmericaModel;

@end

NS_ASSUME_NONNULL_END
