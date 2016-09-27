//
//  ViewControllerTwoDetail.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/22.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerTwoDetail.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "GCD.h"

@interface ViewControllerTwoDetail () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ViewControllerTwoDetail

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.contenturl]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self.contentView addSubview:self.webView];
    
    // 加载页
     self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.loadingView text:@"加载数据中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self.hud hideInLoadingView];
}

@end
