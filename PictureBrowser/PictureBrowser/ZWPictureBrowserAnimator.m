//
//  ZWPictureBrowserAnimator.m
//  PictureBrowser
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ZWPictureBrowserAnimator.h"

@implementation ZWPictureBrowserAnimator

- (instancetype)init {
    self = [super init];
    if (self) {
        _isPresented = NO;
    }
    return self;
}

#pragma mark - UIViewControllerTrasitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _isPresented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresented = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _timeInteval ? _timeInteval : 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (_isPresented) {
        [self animationForPresentView:transitionContext];
    }else {
        [self animationForDismissView:transitionContext];
    }
}

- (void)animationForPresentView:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = transitionContext.containerView;
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView addSubview:presentedView];
    containerView.backgroundColor = [UIColor blackColor];
    presentedView.alpha = 0.0;
    
    if (!_indexPath)return;
    if (!_presentedDelagate)return;
    
    UIImageView *imageView = [_presentedDelagate imageViewForIndexPath:_indexPath];
    
    [containerView addSubview:imageView];
    imageView.frame = [_presentedDelagate startRectForIndexPath:_indexPath];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [_presentedDelagate endRectForIndexPath:_indexPath];
    } completion:^(BOOL finished) {
        presentedView.alpha = 1.0;
        [imageView removeFromSuperview];
        containerView.backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
}


- (void)animationForDismissView:(id <UIViewControllerContextTransitioning> )transitionContext {
    UIView  *dismissedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    if (!_dismissedDelegate)return;
    if (!_presentedDelagate)return;
    
    UIImageView *imageView = [_dismissedDelegate imageView];
    [transitionContext.containerView addSubview:imageView];
    
    NSIndexPath *indexPath = [_dismissedDelegate currentIndexPath];
    CGRect  endRect = [_presentedDelagate startRectForIndexPath:indexPath];
    [dismissedView removeFromSuperview];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (endRect.size.height == 0) {
            imageView.alpha = 0.0;
        }else {
            imageView.frame = endRect;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
