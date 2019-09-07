//
//  main.m
//  Homework_1
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Solve.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    Solve * solve = [[Solve alloc] init];
    [solve get];
    [solve solve];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
