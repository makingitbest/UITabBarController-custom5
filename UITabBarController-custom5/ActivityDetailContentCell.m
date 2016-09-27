//
//  ActivityDetailContentCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/26.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ActivityDetailContentCell.h"
#import "ActivityDetailModel.h"
#import "UIView+SetRect.h"
#import "GCD.h"

@interface ActivityDetailContentCell () <UIWebViewDelegate> {

    BOOL _firstTimeLoadData;
}

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView    *lineView;

@end

@implementation ActivityDetailContentCell

- (void)setUp {
    
    _firstTimeLoadData  = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {
    
    self.webView                          = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 300)];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.delegate                 = self;
    [self addSubview:self.webView];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.lineView];
}

- (void)loadData:(id)data {
    
    NSLog(@"_firstTimeLoadData");
    if (_firstTimeLoadData == NO) {
    
        NSLog(@"_firstTimeLoadData+++++++++=");
        
        _firstTimeLoadData = YES;
        ActivityDetailModel *model = data;
        NSString *cssContentString = [NSString stringWithFormat:@"<html> \n"
                                      "<head> \n"
                                      "<style type=\"text/css\"> \n"
                                      "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
                                      "img  {max-width: 100%% !important;}\n"
                                      "</style> \n"
                                      "</head> \n"
                                      "<body>%@</body> \n"
                                      "</html>", 15.f, @"Heiti SC", @"4C4741", model.content];
        
        [self.webView loadHTMLString:cssContentString baseURL:nil];
        
        NSLog(@"Start - UIWebView %f", self.webView.scrollView.contentSize.height);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSLog(@"SUCESS - UIWebView %f", webView.scrollView.contentSize.height);
    
    self.dataAdapter.cellHeight = webView.scrollView.contentSize.height;
    self.webView.frame          = CGRectMake(10, 10, Width - 20, webView.scrollView.contentSize.height);
    self.lineView.y             = webView.scrollView.contentSize.height;
    [self.tableView reloadData];
}

@end
