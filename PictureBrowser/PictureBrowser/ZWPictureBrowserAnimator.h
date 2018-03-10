//
//  ZWPictureBrowserAnimator.h
//  PictureBrowser
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PresentedAnimationDelegate <NSObject>
///相应item 的图片容器
- (UIImageView *)imageViewForIndexPath:(NSIndexPath *)indexPath;
///动画起始点区域
- (CGRect)startRectForIndexPath:(NSIndexPath *)indexPath;
///动画终点区域
- (CGRect)endRectForIndexPath:(NSIndexPath *)indexPath;
@end

@protocol DismissedAnimationDelegate <NSObject>
///图片容器
- (UIImageView *)imageView;
///当前所浏览图片的indexPath
- (NSIndexPath *)currentIndexPath;

@end

@interface ZWPictureBrowserAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

///yes:为弹出执行的动画 no:退出执行的动画
@property (nonatomic, assign)   BOOL    isPresented;

@property (nonatomic, strong)   NSIndexPath     *indexPath;

/// 动画执行时间
@property (nonatomic, assign)   NSTimeInterval  timeInteval;

///弹出动画协议
@property (nonatomic, weak) id<PresentedAnimationDelegate> presentedDelagate;
///退出动画协议
@property (nonatomic, weak) id<DismissedAnimationDelegate> dismissedDelegate;

@end
