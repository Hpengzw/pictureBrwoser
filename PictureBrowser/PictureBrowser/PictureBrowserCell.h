//
//  PictureBrowserCell.h
//  PictureBrowser
//
//  Created by huang ytand on 2018/3/11.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureBrowserCell : UICollectionViewCell

///根据图片大小计算图片的显示位置
- (CGRect)calculateFrameWithImage:(UIImage *)img;
///图片容器
@property (nonatomic, weak, readonly)   UIImageView  *imageView;

///设置图片
- (void)setPhotoBrowserImgWithImgurl:(NSString *)url;

@end
