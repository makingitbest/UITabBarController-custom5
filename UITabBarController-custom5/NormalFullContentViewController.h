//
//  NormalFullContentViewController.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/27.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

//#import "NormalContentViewController.h"
#import "CustomViewController.h"

@interface NormalFullContentViewController : CustomViewController

/**
 *  导航栏下的内容,所有显示的数据都在这个上面
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  加载动画
 *  处理那种不让返回的控制器,全屏幕的
 */
@property (nonatomic, strong) UIView *windowView;

@end
