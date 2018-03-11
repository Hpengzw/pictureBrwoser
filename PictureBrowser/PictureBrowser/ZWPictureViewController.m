//
//  ZWPictureViewController.m
//  PictureBrowser
//
//  Created by huang ytand on 2018/3/11.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ZWPictureViewController.h"
#import "PictureCell.h"
#import "ZWPictureBrowserViewController.h"
#import "ZWPictureBrowserAnimator.h"

@interface ZWPictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PresentedAnimationDelegate>

@property (nonatomic, strong)   UICollectionView    *collecitonView;
@property (nonatomic, strong)   ZWPictureBrowserAnimator    *browserAnimator;
/// 数据源
@property (nonatomic, strong)   NSMutableArray  *dataSources;


@end

@implementation ZWPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collecitonView];
    self.collecitonView.frame = self.view.bounds;
}

- (NSMutableArray *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableArray arrayWithCapacity:9];
        for (int i = 0; i<9; i++) {
            NSString *path = [NSString stringWithFormat:@"IMG_%d",i+1];
            [_dataSources addObject:path];
        }
    }
    return _dataSources;
}

- (UICollectionView *)collecitonView {
    if (!_collecitonView) {
        UICollectionViewFlowLayout  *fl = [[UICollectionViewFlowLayout alloc]init];
        _collecitonView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:fl];
        _collecitonView.delegate = self;
        _collecitonView.dataSource = self;
        _collecitonView.backgroundColor = [UIColor whiteColor];
        [_collecitonView registerClass:[PictureCell class] forCellWithReuseIdentifier:@"PictureCell"];
        [self.view addSubview:_collecitonView];
    }
    return _collecitonView;
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCell" forIndexPath:indexPath];
    [cell setImageViewUrl:self.dataSources[indexPath.row]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    ZWPictureBrowserViewController *controller = [[ZWPictureBrowserViewController alloc]init];
    controller.indexPath = indexPath;
    controller.dataSources = self.dataSources.mutableCopy;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.browserAnimator;
    _browserAnimator.presentedDelagate = self;
    _browserAnimator.dismissedDelegate = controller;
    _browserAnimator.indexPath = indexPath;
    [self presentViewController:controller animated:YES completion:nil];
}

- (ZWPictureBrowserAnimator *)browserAnimator {
    if (!_browserAnimator) {
        _browserAnimator = [[ZWPictureBrowserAnimator alloc]init];
    }
    return _browserAnimator;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat width = screenSize.width;
    CGFloat space = 2.f;
    CGFloat itemWidth = (width - space *4.f)/3.f;
    return CGSizeMake(itemWidth, itemWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 2.f, 0, 2.f);
}

#pragma mark -- PresentedAnimationDelegate
- (UIImageView *)imageViewForIndexPath:(NSIndexPath *)indexPath {
    UIImageView *imageV = [[UIImageView alloc]init];
    PictureCell *cell = (PictureCell *)[_collecitonView cellForItemAtIndexPath:indexPath];
    imageV.image = cell.imageView.image;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds = YES;
    return imageV;
}

- (CGRect)startRectForIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = (PictureCell *)[_collecitonView cellForItemAtIndexPath:indexPath];
    UIWindow    *window = [UIApplication sharedApplication].keyWindow;
    CGRect frame = cell.frame;
    CGRect startRect = [_collecitonView convertRect:frame toView:window];
    return cell ? startRect : CGRectZero;
}

- (CGRect)endRectForIndexPath:(NSIndexPath *)indexPath {
    PictureCell *cell = (PictureCell *)[_collecitonView cellForItemAtIndexPath:indexPath];
    UIImage *image = cell.imageView.image;
    return [self calculateFrameWithImage:image];
}

- (CGRect)calculateFrameWithImage:(UIImage *)img
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat x = 0;
    CGFloat w = screenSize.width;
    CGFloat h = w /img.size.width * img.size.height;
    CGFloat y = (screenSize.height - h) * 0.5;
    return CGRectMake(x, y, w, h);
}
@end
