//
//  MMLMovieWriter.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/6/28.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLMovieWriter.h"

@interface MMLMovieWriter ()

@property (nonatomic, strong) AVAssetWriter *writer;
@property (nonatomic, strong) AVAssetWriterInput *videoInput;
@property (nonatomic, strong) AVAssetWriterInput *audioInput;

@end

@implementation MMLMovieWriter

- (instancetype)initWithFileURL:(NSURL *)fileURL sourceSize:(CGSize)size
{
    self = [super init];
    if (self) {
        _writer = [AVAssetWriter assetWriterWithURL:fileURL fileType:AVFileTypeMPEG4 error:NULL];
        
        _videoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo
                                                         outputSettings:@{AVVideoCodecKey:AVVideoCodecH264,
                                                                          AVVideoHeightKey:@(size.height),
                                                                          AVVideoWidthKey:@(size.width)
                                                                          }];
        _videoInput.expectsMediaDataInRealTime = YES;
        
        NSDictionary *sourcePixelBufferAttributesDictionary = @{(id)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA),
                                                                (id)kCVPixelBufferWidthKey:@(size.width),
                                                                (id)kCVPixelBufferHeightKey:@(size.height)
                                                                };
        
        _assetWriterPixelBufferInput = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:_videoInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
        
        [_writer addInput:_videoInput];
        
        _audioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio
                                                         outputSettings:@{AVFormatIDKey:@(kAudioFormatMPEG4AAC),
                                                                          AVNumberOfChannelsKey:@(1),
                                                                          AVSampleRateKey:@(44100),
                                                                          AVEncoderBitRateKey:@(128000),
                                                                          }];
        _audioInput.expectsMediaDataInRealTime = YES;
        [_writer addInput:_audioInput];
    }
    return self;
}

- (void)startSessionAtSourceTime:(CMTime)startTime
{
    [self.writer startWriting];
    [self.writer startSessionAtSourceTime:startTime];
}

- (void)appendVideoBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (_videoInput.readyForMoreMediaData == YES && _writer.status == AVAssetWriterStatusWriting) {
        [_videoInput appendSampleBuffer:sampleBuffer];
    }
}

- (void)appendPixelBuffer:(CVPixelBufferRef)pixelBuffer withPresentationTime:(CMTime)presentationTime
{
    if (_videoInput.readyForMoreMediaData == YES && _writer.status == AVAssetWriterStatusWriting) {
        [_assetWriterPixelBufferInput appendPixelBuffer:pixelBuffer withPresentationTime:presentationTime];
    }
}

- (void)appendAudioBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (_audioInput.readyForMoreMediaData && _writer.status == AVAssetWriterStatusWriting) {
        [_audioInput appendSampleBuffer:sampleBuffer];
    }
}

- (void)finishWritingWithCompletionHandler:(void (^)(void))handler
{
    [_writer finishWritingWithCompletionHandler: handler];
}

- (CVPixelBufferRef)createPixelBufferFromImage:(CIImage *)ciImage
{
    CVPixelBufferRef pixelBuffer = NULL;
    CVPixelBufferPoolCreatePixelBuffer(NULL, [self.assetWriterPixelBufferInput pixelBufferPool], &pixelBuffer);
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0 );
    [[CIContext context] render:ciImage toCVPixelBuffer:pixelBuffer];
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0 );
    
    return pixelBuffer;
}

@end


