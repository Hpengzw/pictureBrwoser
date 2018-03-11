//
//  PictureCell.h
//  PictureBrowser
//
//  Created by huang ytand on 2018/3/11.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView   *imageView;

- (void)setImageViewUrl:(NSString *)imageUrl;

@end
