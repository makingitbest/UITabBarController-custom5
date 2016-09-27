//
//  ViewControllerFour.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerFour.h"
#import "ViewControllerFourNext.h"
#import "HexColors.h"

@implementation ViewControllerFour

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self useInteractivePopGestureRecognizer];
    
    [self setNavigationBarItem];
    
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.contentMode         = UIViewContentModeScaleAspectFill;
    imageView.image               = [UIImage imageNamed:@"sky.jpg"];
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.contentView.bounds];
    [button setTitle:@"好奇吗,那就进来看看吧" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    
}

- (void)buttonClick:(UIButton *)button {
    
    ViewControllerFourNext *fourNext  = [[ViewControllerFourNext alloc] init];
    fourNext.title                    = @"fourNext";
    fourNext.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fourNext animated:YES];
}

- (void)setNavigationBarItem {

    self.titleView.backgroundColor = [UIColor colorWithHexString:@"dee5f9"];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = obj;
            button.hidden = YES;
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self enablePopGesture:NO];
}

- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    [self enablePopGesture:YES];
}

@end
