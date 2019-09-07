//
//  Solve.h
//  Homework_1
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Solve : NSObject
@property (nonatomic,retain) NSMutableDictionary* myindegree;
@property (nonatomic,retain) NSMutableDictionary* myhash;

- (void) solve;
- (void) get;
@end

NS_ASSUME_NONNULL_END
