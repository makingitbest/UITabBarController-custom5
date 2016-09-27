//
//  CustomViewController.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController

/**
 *  屏幕的宽度
 */
@property (nonatomic, readonly) CGFloat screenWidth;

/**
 *  屏幕的高度
 */
@property (nonatomic, readonly) CGFloat screenHeight;

/**
 *  导航栏的高度
 */
@property (nonatomic, readonly) CGFloat navigationBarHeight;

/**
 *  状态栏的高度,就是显示电池,无线
 */
@property (nonatomic, readonly) CGFloat statusBarHeight;

/**
 *  返回上级ViewController;
 */
- (void)popViewController;

/**
 *  当控制器为rootViewController时,手动调用
 */
- (void)useInteractivePopGestureRecognizer;

/**
 *  当控制器为rootViewController时,手动调用,用来关闭或者开启手势
 *
 *  @param enable yes or no
 */
-(void)enablePopGesture:(BOOL)enable;

@end
