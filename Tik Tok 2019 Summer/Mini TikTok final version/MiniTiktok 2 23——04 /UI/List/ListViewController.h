//
//  ListViewController.h
//  MiniTiktok
//
//  Created by Alan Young on 2019/7/20.
//  Copyright © 2019 Alan Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model/ItemModel.h"
#import "ListTableViewCell.h"
#import "../../DataManager/DataManager.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NavigationLabel.h"
#import "../Camera/CameraViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController <UITableViewDelegate, UINavigationBarDelegate, UITableViewDataSource, UIImagePickerControllerDelegate>

@end

NS_ASSUME_NONNULL_END
