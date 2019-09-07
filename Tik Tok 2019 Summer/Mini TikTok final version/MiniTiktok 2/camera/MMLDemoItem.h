//
//  MMLDemoItem.h
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/6/25.
//  Copyright © 2019 learning. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMLDemoItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) Class clazz;

@end

NS_ASSUME_NONNULL_END
