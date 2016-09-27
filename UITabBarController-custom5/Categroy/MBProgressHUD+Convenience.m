//
//  MBProgressHUD+Convenience.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "MBProgressHUD+Convenience.h"

@implementation MBProgressHUD (Convenience)

+ (instancetype)showHUDAddedToLoadingView:(UIView *)loadingView text:(NSString *)text {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:loadingView animated:YES];
    hud.label.text     = text;
    
    loadingView.userInteractionEnabled = YES;
    
    return hud;
}

- (void)hideInLoadingView {

    UIView *loadingView = [self superview];
    loadingView.userInteractionEnabled = NO;
    
    [self hideAnimated:YES];
}

@end
