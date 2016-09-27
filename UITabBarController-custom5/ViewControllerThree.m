//
//  ViewControllerThree.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerThree.h"
#import "ViewControllerThreeNext.h"

@interface  ViewControllerThree ()

@end

@implementation ViewControllerThree

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 打开滑动手势
    [self useInteractivePopGestureRecognizer];

    [self setNavigationBar];
    
    UIImageView *imageView        = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.contentMode         = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.image               = [UIImage imageNamed:@"other-15.jpg"];
    [self.contentView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, self.screenWidth - 100, 44)];
    [button setTitle:@"点我进入下一级页面" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
}

- (void)buttonClick:(UIButton *)button {
    
    ViewControllerThreeNext *threeNext = [[ViewControllerThreeNext alloc] init];
    threeNext.title                    = @"threeNext";
    threeNext.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:threeNext animated:YES];
}

- (void)setNavigationBar {

    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = obj;
            button.hidden    = YES;
        }
        
        if ([obj isKindOfClass:[UILabel class]]) {
            
            UILabel *label  = obj;
            label.textColor = [UIColor blueColor];
        }
    }];
}

#pragma mark - 手势
/**
 *  view已经显示 ,就把手势关闭
 *
 *  @param animated
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self enablePopGesture:NO];
}

/**
 *  view已经消失, 允许有侧滑的手势
 *
 *  @param animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self enablePopGesture:YES];
}

@end
