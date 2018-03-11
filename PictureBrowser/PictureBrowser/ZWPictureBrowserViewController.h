//
//  ZWPictureBrowserViewController.h
//  PictureBrowser
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWPictureBrowserAnimator.h"

@interface ZWPictureBrowserViewController : UIViewController<DismissedAnimationDelegate>

/// description
@property (nonatomic, strong)   NSIndexPath  *indexPath;

/// description
@property (nonatomic, strong)   NSMutableArray  *dataSources;

@end
