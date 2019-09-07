//
//  MMLMovieWriter.h
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/6/28.
//  Copyright © 2019 learning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMLMovieWriter : NSObject

@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *assetWriterPixelBufferInput;

- (instancetype)initWithFileURL:(NSURL *)fileURL sourceSize:(CGSize)size;

- (void)startSessionAtSourceTime:(CMTime)startTime;

- (void)appendVideoBuffer:(CMSampleBufferRef)sampleBuffer;

- (void)appendPixelBuffer:(CVPixelBufferRef)pixelBuffer withPresentationTime:(CMTime)presentationTime;

- (void)appendAudioBuffer:(CMSampleBufferRef)sampleBuffer;

- (void)finishWritingWithCompletionHandler:(void (^)(void))handler;

- (CVPixelBufferRef)createPixelBufferFromImage:(CIImage *)ciImage;

@end

NS_ASSUME_NONNULL_END
