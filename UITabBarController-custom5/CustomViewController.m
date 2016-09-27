//
//  CustomViewController.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) CGFloat screenWidth;

@property (nonatomic) CGFloat screenHeight;

@property (nonatomic) CGFloat navigationBarHeight;

@property (nonatomic) CGFloat statusBarHeight;

@end

@implementation CustomViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor                 = [UIColor whiteColor];
    
    self.screenWidth  = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationBarHeight = 44.f;
    self.statusBarHeight     = 20.f;
}

- (void)popViewController {
    
    // 处理了系统的返回上级页面的方法
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)useInteractivePopGestureRecognizer {
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)enablePopGesture:(BOOL)enable {

    self.navigationController.interactivePopGestureRecognizer.enabled = enable;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"[➡️] Enter to --> %@", [self class]);
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"[🕒] Leave from <-- %@", [self class]);
}

- (void)dealloc {

    NSLog(@"[❌] %@ is released.", [self class]);
}

@end
