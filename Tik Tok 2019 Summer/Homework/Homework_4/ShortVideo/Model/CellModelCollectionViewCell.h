//
//  CellModelCollectionViewCell.h
//  ShortVideo
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellModelCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;
//@property (nonatomic, copy) NSString *filmName;
@property (nonatomic, copy) NSString *imageIcon;


//- (instancetype)initWithName:(NSString *)name imageName:(NSString *)imageName iconImageName:(NSString *)iconImageName;
- (instancetype)initWithName:(NSString *)imageName iconImageName:(NSString *)iconImageName;

@end

NS_ASSUME_NONNULL_END
