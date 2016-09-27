//
//  MBProgressHUD+Convenience.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Convenience)

/**
 *  加载效果的显示
 *
 *  @param loadingView loadingView显示
 *  @param text        text内容
 *
 *  @return MBProgressHUD
 */
+ (instancetype)showHUDAddedToLoadingView:(UIView *)loadingView text:(NSString *)text;

/**
 *  隐藏loadingview;
 */
- (void)hideInLoadingView;

@end
