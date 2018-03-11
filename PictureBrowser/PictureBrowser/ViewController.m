//
//  ViewController.m
//  PictureBrowser
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ViewController.h"
#import "ZWPictureViewController.h"

@interface ViewController ()

/// 定义一个按钮，点击跳转
@property (nonatomic, strong)   UIButton  *jump;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jump.frame = CGRectMake(100, 200, 100, 100);
}

- (UIButton *)jump {
    if (!_jump) {
        _jump = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jump setTitle:@"点我跳转" forState:UIControlStateNormal];
        [_jump setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_jump addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_jump];
    }
    return _jump;
}

- (void)jumpAction:(UIButton *)sender {
    ZWPictureViewController *controller = [[ZWPictureViewController alloc]init];
    controller.title = @"小图控制器";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
