//
//  ViewControllerThreeNextDetail.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/24.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerThreeNextDetail.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"

@interface ViewControllerThreeNextDetail () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ViewControllerThreeNextDetail

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
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
