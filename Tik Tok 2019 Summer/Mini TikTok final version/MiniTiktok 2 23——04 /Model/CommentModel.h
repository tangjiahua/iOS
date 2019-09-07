//
//  CommentModel.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/21.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat cellHeight;

-(instancetype)initWithName:(NSString *)name Comment:(NSString *)comment;

@end

NS_ASSUME_NONNULL_END
