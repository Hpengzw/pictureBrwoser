//
//  PictureCell.m
//  PictureBrowser
//
//  Created by huang ytand on 2018/3/11.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "PictureCell.h"

@interface PictureCell  ()

/// 图片展示控件
@property (nonatomic, strong)   UIImageView  *picture;


@end

@implementation PictureCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self picture];
    }
    return self;
}

- (UIImageView *)picture {
    if (!_picture) {
        _picture = [[UIImageView alloc]init];
        [self.contentView addSubview:_picture];
    }
    return _picture;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.picture.frame = self.bounds;
}

- (UIImageView *)imageView {
    return self.picture;
}

- (void)setImageViewUrl:(NSString *)imageUrl {
    UIImage *image = [UIImage imageNamed:imageUrl];
    self.picture.image = image;
}
@end
