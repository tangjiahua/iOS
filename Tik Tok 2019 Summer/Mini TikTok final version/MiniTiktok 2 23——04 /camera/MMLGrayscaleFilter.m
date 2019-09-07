//
//  MMLGrayscaleFilter.m
//  MultiMediaLab
//
//  Created by 刘兵 on 2019/7/7.
//  Copyright © 2019 learning. All rights reserved.
//

#import "MMLGrayscaleFilter.h"

@interface MMLGrayscaleFilter ()
{
    CIImage  *inputImage;
}

@end

static CIColorKernel *customKernel = nil;

@implementation MMLGrayscaleFilter

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        if (customKernel == nil)
        {
            NSBundle *bundle = [NSBundle bundleForClass: [self class]];
            NSURL *kernelURL = [bundle URLForResource:@"Gray" withExtension:@"cikernel"];
            
            NSError *error;
            NSString *kernelCode = [NSString stringWithContentsOfURL:kernelURL
                                                            encoding:NSUTF8StringEncoding error:&error];
            if (kernelCode == nil) {
                NSLog(@"Error loading kernel code string in %@\n%@",
                      NSStringFromSelector(_cmd),
                      [error localizedDescription]);
                abort();
            }
            
            NSArray *kernels = [CIColorKernel kernelsWithString:kernelCode];
            customKernel = [kernels objectAtIndex:0];
        }
    }
    
    return self;
}

- (CIImage *)outputImage
{
    CGRect dod = inputImage.extent;
 
    return [customKernel applyWithExtent:dod roiCallback:^CGRect(int index, CGRect destRect) {
        return destRect;
    } arguments:@[inputImage]];
}

@end
