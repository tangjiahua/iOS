//
//  MMLEffectGenerator.h
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/16.
//  Copyright © 2019 learning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMLEffectGenerator : NSObject

@property (nonatomic,strong) NSArray * filters;

- (void)grayscaleVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;

- (CIImage *)appendEffectsToImage:(CIImage *)image currentNum:(NSInteger)i;

@end

NS_ASSUME_NONNULL_END
