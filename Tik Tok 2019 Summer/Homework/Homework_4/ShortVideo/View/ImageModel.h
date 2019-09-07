//
//  ImageModel.h
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject

@property (nonatomic, copy) NSString *imageTitle;
@property (nonatomic, copy) UIImage *image;

-(instancetype)initWithTitle:(NSString *)title AndName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
