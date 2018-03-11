//
//  PictureBrowserCell.m
//  PictureBrowser
//
//  Created by huang ytand on 2018/3/11.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "PictureBrowserCell.h"

@interface PictureBrowserCell  ()

/// description
@property (nonatomic, strong)   UIImageView  *imageV;


@end

@implementation PictureBrowserCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

- (CGRect)calculateFrameWithImage:(UIImage *)img {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat w = screenSize.width;
    if (img) {
        CGFloat   h = w/img.size.width *img.size.height;
        CGFloat x = 0;
        CGFloat y = (screenSize.height - h) *0.5;
        return CGRectMake(x, y, w, h);
    }else {
        CGFloat  h = w;
        CGFloat x = 0;
        CGFloat y = (screenSize.height - h) *0.5;
        return CGRectMake(x, y, w, h);
    }
}


- (UIImageView *)imageView {
    return self.imageV;
}

- (void)setPhotoBrowserImgWithImgurl:(NSString *)url {
    UIImage *image = [UIImage imageNamed:url];
    self.imageV.image = image;
}
@end
