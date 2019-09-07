//
//  CameraViewController.m
//  Test
//
//  Created by Alan Young on 2019/7/19.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import "CameraViewController.h"

const NSInteger distanceBetweenButtons = 100;

@interface CameraViewController ()<AVCaptureFileOutputRecordingDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *mainSession;
@property (nonatomic, strong) AVCaptureDevice *camera;
@property (nonatomic, strong) AVCaptureDevice *frontCamera;
@property (nonatomic, strong) AVCaptureDevice *microphone;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInputDeviceBack;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInputDeviceFront;
@property (nonatomic, strong) AVCaptureDeviceInput *audioInputDevice;
@property (nonatomic, strong) AVCaptureMovieFileOutput *fileOutput;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *recButton;
@property (nonatomic, strong) UIButton *reverseButton;
@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UIButton *returnButton;

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) NSInteger count;

@end

@implementation CameraViewController

- (void)viewDidLoad
{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self.mainSession addInput:self.videoInputDeviceBack];
    [self.mainSession addInput:self.audioInputDevice];
    _mainSession.sessionPreset = AVCaptureSessionPresetiFrame1280x720;
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_mainSession];
    previewLayer.backgroundColor = [UIColor grayColor].CGColor;
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:previewLayer];
    
    [self.view addSubview:self.recButton];_isRecording = NO;
    self.count = 0;
    [self.view addSubview:self.reverseButton];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.albumButton];
    [self.view addSubview:self.returnButton];
    
    [_mainSession startRunning];
}

#pragma mark - actions

-(void) recButtonClick
{
    //准备录制
//    NSLog(@"按钮按下");
    if (_isRecording) {
        //停止录制
        [self.fileOutput stopRecording];
        [self.recButton setBackgroundColor:[UIColor whiteColor]];
        
        self.reverseButton.enabled = YES;
        _isRecording = NO;
        _timeLabel.alpha = 0;
        [self.displayLink setPaused:YES];
    }
    else
    {
        //开始录制
        [self.recButton setBackgroundColor:[UIColor redColor]];
        self.reverseButton.enabled = NO;
        _isRecording = YES;
        _count = 0;
        _timeLabel.alpha = 1;
        [self.displayLink setPaused:NO];
        
        NSString *path = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"MyVedio%@.mp4",[NSDate  date]]];
        NSURL *filrURL = [NSURL fileURLWithPath:path];
        
        [self.fileOutput startRecordingToOutputFileURL:filrURL recordingDelegate:self];
        
    }
}

-(void) reverseButtonClick
{
    //翻转摄像头
    if ([_reverseButton.titleLabel.text isEqualToString:@"前"]) {
        [_reverseButton setTitle:@"后" forState:UIControlStateNormal];
        [_mainSession removeInput:self.videoInputDeviceBack];
        [_mainSession addInput:self.videoInputDeviceFront];
    }
    else
    {
        [_reverseButton setTitle:@"前" forState:UIControlStateNormal];
        [_mainSession removeInput:self.videoInputDeviceFront];
        [_mainSession addInput:self.videoInputDeviceBack];
    }
}

- (void) returnButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters

- (AVCaptureDevice *)microphone
{
    if (!_microphone) {
        _microphone = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    }
    return _microphone;
}

- (AVCaptureDevice *)camera
{
    if (!_camera) {
        _camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _camera;
}

- (AVCaptureDevice *)frontCamera
{
    if (!_frontCamera) {
        _frontCamera = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    }
    return _frontCamera;
}

- (AVCaptureDeviceInput *)videoInputDeviceBack
{
    if (!_videoInputDeviceBack) {
        _videoInputDeviceBack = [AVCaptureDeviceInput deviceInputWithDevice:self.camera error:nil];
    }
    return _videoInputDeviceBack;
}

- (AVCaptureDeviceInput *)videoInputDeviceFront
{
    if (!_videoInputDeviceFront) {
        _videoInputDeviceFront = [AVCaptureDeviceInput deviceInputWithDevice:self.frontCamera error:nil];
    }
    return _videoInputDeviceFront;
}

- (AVCaptureDeviceInput *)audioInputDevice
{
    if (!_audioInputDevice) {
        _audioInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:self.microphone error:nil];
    }
    return _audioInputDevice;
}

- (AVCaptureSession *)mainSession
{
    if (!_mainSession) {
        _mainSession = [[AVCaptureSession alloc] init];
    }
    return _mainSession;
}

- (AVCaptureMovieFileOutput *)fileOutput
{
    if (!_fileOutput) {
        _fileOutput = [[AVCaptureMovieFileOutput alloc] init];
        
        [self.mainSession beginConfiguration];
        if ([self.mainSession canAddOutput:_fileOutput]) {
            [self.mainSession addOutput:_fileOutput];
        }
        [self.mainSession commitConfiguration];
    }
    return _fileOutput;
}

- (dispatch_queue_t)queue
{
    if (!_queue) {
        _queue = dispatch_queue_create("video_capture_queue", NULL);
    }
    return _queue;
}

- (UIButton *)recButton
{
    if (!_recButton) {
        CGFloat radius = 30;
        CGFloat topDis = CGRectGetHeight(self.view.bounds) * 4 / 5 - radius;
        CGFloat leftDis = CGRectGetWidth(self.view.bounds) / 2 - radius;
        _recButton = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, topDis, radius * 2, radius * 2)];
        
        _recButton.backgroundColor = [UIColor whiteColor];
        _recButton.layer.cornerRadius = radius;
//        _recButton.layer.borderWidth = 5;
//        _recButton.layer.borderColor = [UIColor blackColor].CGColor;
        
        //增加白环sublayer
        CGFloat ringRadius = 36;
        CAShapeLayer *ring = [[CAShapeLayer alloc] init];
        UIBezierPath *ringPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(radius - ringRadius, radius - ringRadius, ringRadius * 2, ringRadius * 2)];
        ring.path = ringPath.CGPath;
        ring.strokeColor = [UIColor whiteColor].CGColor;
        ring.lineWidth = 4;
        ring.fillColor = [UIColor clearColor].CGColor;
        [_recButton.layer addSublayer:ring];
        
        [_recButton addTarget:self action:@selector(recButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recButton;
}

- (UIButton *)reverseButton
{
    if (!_reverseButton) {
        CGFloat radius = 20;
        CGFloat topDis = self.recButton.frame.origin.y +  self.recButton.layer.cornerRadius - radius;
        CGFloat leftDis = self.recButton.frame.origin.x + self.recButton.layer.cornerRadius - radius + distanceBetweenButtons;
        _reverseButton = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, topDis, radius * 2, radius * 2)];
        
        _reverseButton.layer.cornerRadius = radius;
        _reverseButton.backgroundColor = [UIColor clearColor];
        [_reverseButton setTitle:@"前" forState:UIControlStateNormal];
        [_reverseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reverseButton.layer.borderWidth = 2;
        _reverseButton.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [_reverseButton addTarget:self action:@selector(reverseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reverseButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _timeLabel.text = @"00:00:00";
        [_timeLabel adjustsFontSizeToFitWidth];
        [_timeLabel setFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2 - CGRectGetWidth(_timeLabel.bounds)/2, 0, CGRectGetWidth(_timeLabel.bounds), CGRectGetHeight(_timeLabel.bounds))];
        _timeLabel.alpha = 0;
    }
    return _timeLabel;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(countTime)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

- (UIButton *)albumButton
{
    if (!_albumButton) {
        NSInteger radius = 20;
        CGFloat topDis = self.recButton.frame.origin.y + _recButton.layer.cornerRadius - radius;
        CGFloat leftDis = self.recButton.frame.origin.x + _recButton.layer.cornerRadius - distanceBetweenButtons - radius;
        
        _albumButton = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, topDis, radius * 2, radius * 2)];
        _albumButton.layer.cornerRadius = radius;
        _albumButton.layer.borderWidth = 2;
        _albumButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _albumButton.backgroundColor = [UIColor clearColor];
        [_albumButton setTitle:@"册" forState:UIControlStateNormal];
        [_albumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_albumButton addTarget:self action:@selector(pickMedia) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _albumButton;
}

- (UIButton *)returnButton
{
    if (!_returnButton) {
        NSInteger radius = 20;
        CGFloat topDis = self.recButton.frame.origin.y + _recButton.layer.cornerRadius + distanceBetweenButtons - radius;
        CGFloat leftDis = self.recButton.frame.origin.x + _recButton.layer.cornerRadius - radius;
        
        _returnButton = [[UIButton alloc] initWithFrame:CGRectMake(leftDis, topDis, radius * 2, radius * 2)];
        _returnButton.layer.cornerRadius = radius;
        _returnButton.layer.borderWidth = 2;
        _returnButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _returnButton.backgroundColor = [UIColor clearColor];
        [_returnButton setTitle:@"返" forState:UIControlStateNormal];
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_returnButton addTarget:self action:@selector(returnButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(NSError *)error
{
    if (!error) {
        UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)video:(NSString *) videoPath
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo
{
    if (!error) {
        [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:videoPath] error:NULL];
        NSLog(@"保存成功！");
        //上传视频 by myself
        [self __didPickAndUploadVideoURL:[NSURL fileURLWithPath:videoPath]];
    }
}

#pragma displayLink

-(void)countTime
{
    if (_count%60 == 0)
    {
        long nowHour =_count/(216000)%60;
        long nowMin = _count/(3600)%60;
        long nowSec = _count/60%60;
        [self.timeLabel setText:[NSString stringWithFormat:@"%02ld:%02ld:%02ld",nowHour,nowMin,nowSec]];
    }
    _count++;
}

#pragma mark - override

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Upload videos from album
- (void)pickMedia {
    // Demo 1-1: 打开 UIImagePickerController
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerController.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
    [self presentViewController:pickerController animated:YES completion:nil];
    pickerController.delegate = self;
    
    return ;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSURL *videoURL = info[UIImagePickerControllerMediaURL];
    
    // Demo 1-2: 获取选择后视频
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"picked video URL :%@",videoURL);
    }];
    
    //Demo 1-3 上传视频
    [self __didPickAndUploadVideoURL:videoURL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)__didPickVideoURL:(NSURL *)videoURL {
    ItemModel *newItem = [[ItemModel alloc] init];
    newItem.title = @"";
    newItem.videoId = 0;
    newItem.videoURL = [videoURL absoluteString];
}

- (void)__didPickAndUploadVideoURL:(NSURL *)videoURL
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Describe your video" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"What's this video about?";
    }];
    __weak typeof(alertController) weakAlertController = alertController;
    __weak typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakAlertController) alertController = weakAlertController;
        __strong typeof(weakSelf) self = weakSelf;
        NSString *title = alertController.textFields.firstObject.text;
        if (!title.length) {
            title = @"No description";
        }
        
//        [DataManager uploadVideoFromURL:videoURL
//                              withTitle:title
//                        completionBlock:^(ItemModel * _Nullable result, NSError * _Nullable error) {
//                            NSLog(@"uploaded video: %@", result.videoURL);
//
//                            //                              dispatch_async(dispatch_get_main_queue(), ^{
//                            //                                  if (result && !error) {
//                            //                                      [self.items insertObject:result atIndex:0];
//                            //                                      [self.tableView scrollsToTop];
//                            //                                      [self.tableView reloadData];
//                            //                                      [self playFirstVideo];
//                            //                                  } else {
//                            //                                      UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Failed to upload video" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
//                            //                                      [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
//                            //                                      [self presentViewController:errorAlert animated:YES completion:nil];
//                            //                                  }
//                            //                              });
//                        }];
        //上传视频 by myself
        [self uploadVideoWithUrl:videoURL title:title];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - uploadVideo

-(void) uploadVideoWithUrl:(NSURL *)url title:(NSString *)title
{
    ;
}

@end
