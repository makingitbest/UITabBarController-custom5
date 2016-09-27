//
//  CustomNavigationController.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController hideNavigationBar:(BOOL)hide {
    
    CustomNavigationController *nc = [[[self class] alloc] initWithRootViewController:rootViewController];
    [rootViewController.navigationController setNavigationBarHidden:hide];
    
    return nc;
}

@end
