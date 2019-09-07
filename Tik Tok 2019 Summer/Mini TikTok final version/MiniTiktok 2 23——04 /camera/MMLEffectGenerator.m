//
//  MMLEffectGenerator.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/16.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLEffectGenerator.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "MMLGrayscaleFilter.h"
#import "MMLVignetteFilter.h"

@interface MMLEffectGenerator ()

@property (nonatomic, strong) CIContext *faceDetectContext;
@property (nonatomic, strong) CIDetector *detector;



@end

@implementation MMLEffectGenerator

- (CIImage *)InvertFilterImage:(CIImage *)inputImage
{
    CIFilter* InvertFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    //CIPhotoEffectChrome
    //CIPhotoEffectFade
    //CIPhotoEffectInstant
    [InvertFilter setValue:inputImage forKey:kCIInputImageKey];
    return InvertFilter.outputImage;
}
- (void) getFiltersArray
{
    CIFilter* CIPhotoEffectInstant = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    CIFilter* CIPhotoEffectChrome = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    CIFilter* CIPhotoEffectFade = [CIFilter filterWithName:@"CIPhotoEffectFade"];
    CIFilter* InvertFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _faceDetectContext = [CIContext context];
        NSDictionary *opts = @{CIDetectorAccuracy : CIDetectorAccuracyHigh};
        _detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                       context:_faceDetectContext
                                       options:opts];
    }
    return self;
}

- (void)grayscaleVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    const int BYTES_PER_PIXEL = 4;
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    size_t bufferWidth = CVPixelBufferGetWidth(pixelBuffer);
    size_t bufferHeight = CVPixelBufferGetHeight(pixelBuffer);
    
    unsigned char *pixel = CVPixelBufferGetBaseAddress(pixelBuffer);
    unsigned char grayPixel;
    
    for (int row = 0; row < bufferHeight; row++) {
        for (int column = 0; column < bufferWidth; column++) {
            grayPixel = (pixel[0] + pixel[1] + pixel[2]) / 3;
            pixel[0] = pixel[1] = pixel[2] = grayPixel;
            pixel += BYTES_PER_PIXEL;
        }
    }
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
}

- (CIImage *)bloomFilterImage:(CIImage *)inputImage
                withIntensity:(CGFloat)intensity
                       radius:(CGFloat)radius
{
    CIFilter* bloomFilter = [CIFilter filterWithName:@"CIBloom"];
    [bloomFilter setValue:inputImage forKey:kCIInputImageKey];
    [bloomFilter setValue:@(intensity) forKey:kCIInputIntensityKey];
    [bloomFilter setValue:@(radius) forKey:kCIInputRadiusKey];
    return bloomFilter.outputImage;
}

- (CIImage *)vignetteFilterImage:(CIImage *)inputImage
                      withCenter:(CGPoint)center
                          radius:(CGFloat)radius
{
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignetteEffect"];
    CIVector *centerVector = [CIVector vectorWithCGPoint:center];
    [vignetteFilter setValue:inputImage forKey:kCIInputImageKey];
    [vignetteFilter setValue:centerVector forKey:kCIInputCenterKey];
    [vignetteFilter setValue:@(radius) forKey:kCIInputRadiusKey];
    return vignetteFilter.outputImage;
}

- (CIImage *)appendEffectsToImage:(CIImage *)image currentNum:(NSInteger)i
{
    if (i==0) {
        CIImage *originalImage = image;
        CIFilter *filter;
        
        CGFloat radius = 0.4 * MAX(image.extent.size.width, image.extent.size.height);
        CGPoint center = CGPointMake(image.extent.size.width/2.0, image.extent.size.height/2.0);
        image = [self vignetteFilterImage:image withCenter:center radius:radius];
        NSArray *features = [self.detector featuresInImage:originalImage options:nil];
        
        UIImage *smileImage = [UIImage imageNamed:@"smile"];
        CIImage *smile = [[CIImage alloc] initWithImage:smileImage];
        
        for (CIFaceFeature *f in features)
        {
            filter = [CIFilter filterWithName: @"CISourceOverCompositing"];
            
            CGPoint origin = f.bounds.origin;
            CGFloat scaleX = f.bounds.size.width/smile.extent.size.width;
            CGFloat scaleY = f.bounds.size.height/smile.extent.size.height;
            CGAffineTransform transform1 = CGAffineTransformMakeScale(scaleX, scaleY);
            CGAffineTransform transform2 = CGAffineTransformMakeTranslation(origin.x, origin.y);
            CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
            [filter setValue:[smile imageByApplyingTransform:transform] forKey: @"inputImage"];
            [filter setValue: image forKey: @"inputBackgroundImage"];
            image = [filter outputImage];
        }
    }
    if (i==1)
    {
        CIFilter* InvertFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
        [InvertFilter setValue:image forKey:kCIInputImageKey];
        return InvertFilter.outputImage;
    }
    if (i==2)
    {
        CIFilter* InvertFilter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
        [InvertFilter setValue:image forKey:kCIInputImageKey];
        return InvertFilter.outputImage;
    }
    if (i==3)
    {
        CIFilter* InvertFilter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
        [InvertFilter setValue:image forKey:kCIInputImageKey];
        return InvertFilter.outputImage;
    }
    return image;
}

@end
