//
//  ZWPictureBrowserViewController.m
//  PictureBrowser
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ZWPictureBrowserViewController.h"
#import "PictureBrowserCell.h"

@interface ZWPictureBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)   UICollectionView    *collectionView;

@end

@implementation ZWPictureBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewFrame];
    self.collectionView.frame = self.view.bounds;
    [_collectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        fl.itemSize = CGSizeMake(screenSize.width + 15, screenSize.height);
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        fl.minimumLineSpacing = 0;
        fl.minimumInteritemSpacing = 0;
        fl.collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:fl];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[PictureBrowserCell class] forCellWithReuseIdentifier:@"PictureBrowserCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (void)setViewFrame {
    CGRect frame = self.view.frame;
    frame.size.width += 15;
    self.view.frame = frame;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureBrowserCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"PictureBrowserCell" forIndexPath:indexPath];
    [cell setPhotoBrowserImgWithImgurl:_dataSources[indexPath.row]];
    cell.imageView.frame = [cell calculateFrameWithImage:cell.imageView.image];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DismissedAnimationDelegate

- (UIImageView *)imageView {
    UIImageView *imageView = [[UIImageView alloc]init];
    PictureBrowserCell *cell = _collectionView.visibleCells[0];
    imageView.image = cell.imageView.image;
    imageView.frame = cell.imageView.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (NSIndexPath *)currentIndexPath
{
    PictureBrowserCell *cell = _collectionView.visibleCells[0];
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    return indexPath;
}


@end
