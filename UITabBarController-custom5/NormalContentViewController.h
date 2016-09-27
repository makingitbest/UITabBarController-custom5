//
//  NormalContentViewController.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "CustomViewController.h"

@interface NormalContentViewController : CustomViewController

/**
 *  导航栏
 */
@property (nonatomic, strong) UIView *titleView;

/**
 *  导航栏下的内容,所有显示的数据都在这个上面
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  加载动画
 */
@property (nonatomic, strong) UIView *loadingView;

/**
 *  处理那种不让返回的控制器,全屏幕的
 */
@property (nonatomic, strong) UIView *windowView;

@end

