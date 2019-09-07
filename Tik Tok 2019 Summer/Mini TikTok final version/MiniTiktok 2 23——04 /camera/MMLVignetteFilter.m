//
//  MMLVignetteFilter.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/7.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLVignetteFilter.h"

@interface MMLVignetteFilter ()
{
    CIImage  *inputImage;
    NSNumber *inputAlpha;
}

@end

static CIColorKernel *customKernel = nil;

@implementation MMLVignetteFilter

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (customKernel == nil)
        {
            NSBundle *bundle = [NSBundle bundleForClass: [self class]];
            NSURL *kernelURL = [bundle URLForResource:@"Vignette"
                                        withExtension:@"cikernel"];
            NSString *kernelCode = [NSString stringWithContentsOfURL:kernelURL
                                                            encoding:NSUTF8StringEncoding
                                                               error:NULL];
            if (kernelCode) {
                NSArray *kernels = [CIColorKernel kernelsWithString:kernelCode];
                customKernel = [kernels objectAtIndex:0];
            }
        }
    }
    return self;
}

- (void)setDefaults
{
    
}

- (CIImage *)outputImage
{
    CGRect dod = inputImage.extent;
    CGFloat radius = 0.5 * MAX(dod.size.width, dod.size.height);
    CIVector *center = [CIVector vectorWithX:dod.size.width / 2.0
                                           Y:dod.size.height / 2.0];
    
    CIKernelROICallback roiCallback = ^CGRect(int index, CGRect destRect) {
        return destRect;
    };
    
    
    return [customKernel applyWithExtent:dod
                             roiCallback:roiCallback
                               arguments:@[inputImage,
                                           center,
                                           @(radius),
                                           inputAlpha ?: @(0.0)]];
}

@end

