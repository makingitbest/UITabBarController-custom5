//
//  CustomNavigationController.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController

/**
 *  设置导航栏,并设置显示
 *
 *  @param rootViewController rootViewController
 *  @param hide               隐藏导航栏.为了自定制导航栏
 *
 *  @return 返回    CustomNavigationController
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController hideNavigationBar:(BOOL)hide;

@end
