//
//  BITHeroModel.h
//  BITGalary
//
//  Created by 郝一鹏 on 2019/6/30.
//  Copyright © 2019 Me55a. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BITFilmModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *filmName;
@property (nonatomic, copy) NSString *filmDescription;
@property (nonatomic, copy) NSString *filmIcon;
@property (nonatomic, assign) BOOL isFavorite;

- (instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName iconImageName:(NSString *)iconImageName filmDescription:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
