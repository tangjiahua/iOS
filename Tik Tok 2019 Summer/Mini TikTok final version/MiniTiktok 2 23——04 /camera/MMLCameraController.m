//
//  MMLCameraController.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/6.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLCameraController.h"

@interface MMLCameraController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDevice *audioDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioDeviceInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureAudioDataOutput *audioDataOutput;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation MMLCameraController

- (void)setup
{
    self.videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    self.audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    self.videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:NULL];
    self.audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.audioDevice error:NULL];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    if ([self.captureSession canAddInput:self.videoDeviceInput]) {
        [self.captureSession addInput:self.videoDeviceInput];
    }
    
    if ([self.captureSession canAddInput:self.audioDeviceInput]) {
        [self.captureSession addInput:self.audioDeviceInput];
    }
    
    
    self.captureSessionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    
    NSDictionary *outputSetting = @{(id)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)};
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.videoDataOutput.videoSettings = outputSetting;
    
    [self.videoDataOutput setSampleBufferDelegate:self queue:self.captureSessionQueue];
    self.videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    
    if ([self.captureSession canAddOutput:self.videoDataOutput]) {
        [self.captureSession addOutput:self.videoDataOutput];
    }
    
    self.audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    [self.audioDataOutput setSampleBufferDelegate:self queue:self.captureSessionQueue];
    
    if ([self.captureSession canAddOutput:self.audioDataOutput]) {
        [self.captureSession addOutput:self.audioDataOutput];
    }
    
    self.captureSession.usesApplicationAudioSession = NO;
    
    AVCaptureConnection *videoConnection = [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([videoConnection isVideoOrientationSupported]) {
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    if ([videoConnection isVideoMirroringSupported] && self.videoDevice.position == AVCaptureDevicePositionFront) {
        [videoConnection setVideoMirrored:YES];
    }
}

- (void)stopCapture
{
    if (self.captureSession.isRunning) {
        dispatch_async(self.captureSessionQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}

- (void)startCapture
{
    if (!self.captureSession.isRunning) {
        dispatch_async(self.captureSessionQueue, ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)captureOutput:(AVCaptureOutput *)output
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection;
{
    if (output == self.videoDataOutput && self.didOutputVideoSampleBuffer   ) {
        self.didOutputVideoSampleBuffer(sampleBuffer);
    } else if (output == self.audioDataOutput && self.didOutputAudioSampleBuffer) {
        self.didOutputAudioSampleBuffer(sampleBuffer);
    }
}

@end
