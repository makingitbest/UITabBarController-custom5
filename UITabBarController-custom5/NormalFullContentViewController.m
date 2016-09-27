//
//  NormalFullContentViewController.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/27.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "NormalFullContentViewController.h"

@implementation NormalFullContentViewController


- (void)viewDidLoad {

    [super viewDidLoad];
        
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];
    [self.view addSubview:self.contentView];
    
    self.windowView                        = [[UIView alloc] initWithFrame:self.view.bounds];
    self.windowView.userInteractionEnabled = NO;
    [self.view addSubview:self.windowView];
}

@end
