//
//  MMLCameraViewController.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/6/25.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLCameraViewController.h"
#import "MMLCameraInteractionView.h"
#import "MMLCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>
#import "MMLMovieWriter.h"
#import "MMLEffectGenerator.h"

@interface MMLCameraViewController ()

@property (nonatomic, strong) MMLCameraInteractionView *cameraInteractionView;

@property (nonatomic, strong) MMLCameraController *cameraController;

@property (nonatomic, strong) GLKView *videoPreviewView;
@property (nonatomic, strong) CIContext *ciContext;
@property (nonatomic, strong) EAGLContext *eaglContext;
@property (nonatomic, assign) CGRect videoPreviewViewBounds;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) MMLEffectGenerator *effectGenerator;

@property (nonatomic, strong) MMLMovieWriter *movieWriter;
@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, assign) NSInteger currentNum;

@end

@implementation MMLCameraViewController

- (void)dealloc
{
    [self.videoPreviewView deleteDrawable];
}

- (void)startRecording
{
    self.isRecording = YES;
}

- (void)finishRecording
{
    if (!self.isRecording) {
        return;
    }
    self.isRecording = NO;
    
    dispatch_async(self.cameraController.captureSessionQueue, ^{
        [self.movieWriter finishWritingWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self uploadVideoWithUrl:self.videoURL title:@"test"];
                UISaveVideoAtPathToSavedPhotosAlbum(self.videoURL.path, self, @selector(video: didFinishSavingWithError:contextInfo:), nil);
            });
        }];
    });
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:videoPath] error:NULL];
        [self.cameraController stopCapture];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)processVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
//    [self.effectGenerator grayscaleVideoSampleBuffer:sampleBuffer];
    self.currentNum = _cameraInteractionView.i;
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *image = [CIImage imageWithCVPixelBuffer:(CVPixelBufferRef)imageBuffer options:nil];
    
    //TODO: 滤镜
    image = [self.effectGenerator appendEffectsToImage:image currentNum:self.currentNum];
    
    
    
    
    [self.videoPreviewView bindDrawable];
    
    [self.ciContext drawImage:image inRect:self.videoPreviewViewBounds fromRect:image.extent];
    [self.videoPreviewView display];
    
    if (self.isRecording) {
        if (!self.movieWriter) {
            NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"myVideo.mp4"];
            self.videoURL = [NSURL fileURLWithPath:path];
            
            MMLMovieWriter *moviewWriter = [[MMLMovieWriter alloc] initWithFileURL:self.videoURL
                                                                        sourceSize:image.extent.size];
            self.movieWriter = moviewWriter;
            [self.movieWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
        }
        
        CVPixelBufferRef pixelBuffer = [self.movieWriter createPixelBufferFromImage:image];
        [self.movieWriter appendPixelBuffer:pixelBuffer withPresentationTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
        CVPixelBufferRelease(pixelBuffer);
    }
}

- (void)processAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (self.isRecording) {
        [self.movieWriter appendAudioBuffer:sampleBuffer];
    }
}

- (void)createVideoPreviewView
{
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *videoPreviewView = [[GLKView alloc] initWithFrame:self.view.bounds
                                                       context:eaglContext];
    videoPreviewView.enableSetNeedsDisplay = NO;
    
    [self.view addSubview:videoPreviewView];
    
    self.videoPreviewView = videoPreviewView;
    self.eaglContext = eaglContext;
    self.ciContext = [CIContext contextWithEAGLContext:eaglContext
                                               options:@{kCIContextWorkingColorSpace:[NSNull null]}];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    self.videoPreviewViewBounds = CGRectMake(0,
                                             0,
                                             CGRectGetWidth(self.view.bounds) * scale,
                                             CGRectGetHeight(self.view.bounds) * scale);
}

- (void)recordButtionTap:(UIButton *)sender
{
    BOOL desStatus = !self.isRecording;
    
    CGFloat cornerRadius = desStatus ? 10.0f : 60.0f/2.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.cameraInteractionView.recordButton.layer.cornerRadius = cornerRadius;
    }];
    
    if (desStatus) {
        [self startRecording];
    } else {
        [self finishRecording];
    }
}

- (void)actionButtonTap:(UIButton *)sender
{

}

- (void)backButtionTap:(UIButton *)sender
{
    [self.cameraController stopCapture];
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createCameraInteractionView
{
    self.cameraInteractionView = [[MMLCameraInteractionView alloc] init];
    self.cameraInteractionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.cameraInteractionView.backButton addTarget:self
                                              action:@selector(backButtionTap:)
                                    forControlEvents:UIControlEventTouchUpInside];

    [self.cameraInteractionView.recordButton addTarget:self
                                                action:@selector(recordButtionTap:)
                                      forControlEvents:UIControlEventTouchUpInside];

    [self.cameraInteractionView.actionButton addTarget:self
                                              action:@selector(actionButtonTap:)
                                    forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.cameraInteractionView];
    
    NSLayoutConstraint *constraint;

    constraint = [NSLayoutConstraint
                  constraintWithItem:self.cameraInteractionView
                  attribute:NSLayoutAttributeTop
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeTop
                  multiplier:1.0f
                  constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:self.cameraInteractionView
                  attribute:NSLayoutAttributeLeft
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeLeft
                  multiplier:1.0f
                  constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:self.cameraInteractionView
                  attribute:NSLayoutAttributeRight
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeRight
                  multiplier:1.0f
                  constant:0.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint
                  constraintWithItem:self.cameraInteractionView
                  attribute:NSLayoutAttributeBottom
                  relatedBy:NSLayoutRelationEqual
                  toItem:self.view
                  attribute:NSLayoutAttributeBottom
                  multiplier:1.0f
                  constant:0.0f];
    [self.view addConstraint:constraint];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createVideoPreviewView];
    [self createCameraInteractionView];
    
    self.effectGenerator = [[MMLEffectGenerator alloc] init];

    self.cameraController = [[MMLCameraController alloc] init];
    
    __weak typeof (self) weakSelf = self;
    self.cameraController.didOutputVideoSampleBuffer = ^(CMSampleBufferRef sampleBuffer){
        [weakSelf processVideoSampleBuffer:sampleBuffer];
    };
    
    self.cameraController.didOutputAudioSampleBuffer = ^(CMSampleBufferRef sampleBuffer){
        [weakSelf processAudioSampleBuffer:sampleBuffer];
    };
    
    [self.cameraController setup];
    [self.cameraController startCapture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}




//传参数到这里，上传视频
#pragma mark - uploadVideo

-(void) uploadVideoWithUrl:(NSURL *)url title:(NSString *)title
{
    NSLog(@"onUploadTaskClicked");
    
    //2 - setup request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.xiongdianpku.com/api/bytedance/video/upload?title=%@&tag=group_232", title]]];
    
    [request setHTTPMethod:@"POST"];
    
    //set header
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", [NSUUID new].UUIDString];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    NSString *boundaryPrefix = [NSString stringWithFormat:@"--%@\r\n",boundary];
    [body appendData:[boundaryPrefix dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;name=\"%@\"; filename=\"%@\"\r\n", @"video", @"testmyvideo.mp4"]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"video/mp4"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithContentsOfURL:url]];
    
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    [body appendData: [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@--", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = body;
    request.timeoutInterval = 60;
    
    
    //3 init task
    self.task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error || !data) {
            NSLog(@"Upload failed! Error: %@",error);
            return ;
        }
        else{
            NSLog(@"success");
        }
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([responseData[@"success"] boolValue]) {
            
        } else {
            
        }
    }];
    //4- start the task
    [self.task resume];
}

@end
