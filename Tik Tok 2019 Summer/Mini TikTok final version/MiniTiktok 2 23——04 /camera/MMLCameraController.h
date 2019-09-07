//
//  MMLCameraController.h
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/6.
//  Copyright © 2019 learning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMLCameraController : NSObject

@property (nonatomic, strong) dispatch_queue_t captureSessionQueue;

@property (nonatomic, copy) void (^didOutputVideoSampleBuffer)(CMSampleBufferRef sampleBuffer);
@property (nonatomic, copy) void (^didOutputAudioSampleBuffer)(CMSampleBufferRef sampleBuffer);

- (void)setup;

- (void)stopCapture;

- (void)startCapture;

@end

NS_ASSUME_NONNULL_END
