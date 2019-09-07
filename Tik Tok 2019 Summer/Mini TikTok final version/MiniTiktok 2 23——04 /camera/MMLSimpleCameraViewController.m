//
//  MMLSimpleCameraViewController.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/17.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLSimpleCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MMLSimpleCameraViewController ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDevice *audioDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioDeviceInput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureMovieFileOutput *fileOutput;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) UIView *previewView;

@end

@implementation MMLSimpleCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *previewView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:previewView];
    self.previewView = previewView;
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    recordButton.backgroundColor = [UIColor blueColor];
    [recordButton addTarget:self action:@selector(recordButtionTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
    self.recordButton = recordButton;
    
    self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
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
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.frame = self.previewView.bounds;
    [self.previewView.layer addSublayer:self.previewLayer];
    
    self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [self.captureSession startRunning];
}

- (void)recordButtionTap:(UIButton *)sender
{
    if (!self.fileOutput) {
        self.fileOutput = [[AVCaptureMovieFileOutput alloc] init];
        
        [self.captureSession beginConfiguration];
        
        if ([self.captureSession canAddOutput:self.fileOutput]) {
            [self.captureSession addOutput:self.fileOutput];
        }
        
        [self.captureSession commitConfiguration];
    }
    
    if (!self.fileOutput.isRecording) {
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myVideo.mp4"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        [self.fileOutput startRecordingToOutputFileURL:fileURL recordingDelegate:self];
        
        self.recordButton.backgroundColor = [UIColor redColor];
    } else {
        [self.fileOutput stopRecording];
        
        self.recordButton.backgroundColor = [UIColor blueColor];
    }
}

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error
{
    if (!error) {
        UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, self, @selector(video: didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:videoPath] error:NULL];
        [self.captureSession stopRunning];
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
