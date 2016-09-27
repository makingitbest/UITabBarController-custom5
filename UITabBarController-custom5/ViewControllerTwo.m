//
//  ViewControllerTwo.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "Networking.h"
#import "SelectCell.h"
#import "SelectModel.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "GCD.h"
#import "ViewControllerTwoDetail.h"

@interface ViewControllerTwo () <NetworkingDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Networking     *selectNetwoking;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *selectDataArray;
@property (nonatomic, strong) MBProgressHUD  *hud;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 打开滑动手势
    [self useInteractivePopGestureRecognizer];
    
    self.selectDataArray = [NSMutableArray array];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = obj;
            button.hidden = YES;
        }
        
    }];
        
    self.selectNetwoking = [Networking networkingWithUrlString:@"http://api.chuandazhiapp.com/v2/channels/5/items?limit=20&offset=0&gender=2&generation=1"
                                              requestParameter:nil
                                                      delegate:self
                                                   requestBody:kHTTPBodyType
                                              responseDataType:kJSONResponseType
                                                 requestMethod:kGETMethodType];
    [self.selectNetwoking startRequest];
    
    // 加载页
    self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.loadingView text:@"加载数据中..."];
    
    self.tableView            = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];
}

#pragma mark - networkingDelegate

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {
    
    [self.hud hideInLoadingView];

    NSMutableArray *array = data[@"data"][@"items"];
    for (NSDictionary *dic in array) {
        
        SelectModel *model = [[SelectModel alloc] initWithDictionary:dic];
        [self.selectDataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {
 
    NSLog(@"%@", error);
    
    [self.hud hideInLoadingView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"];
    SelectModel  *model        = self.selectDataArray[indexPath.row];
    [cell loadData:model];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SelectModel  *model = self.selectDataArray[indexPath.row];
    
    ViewControllerTwoDetail *controllerTwoDetail = [[ViewControllerTwoDetail alloc] init];
    controllerTwoDetail.title                    = model.short_title;
    controllerTwoDetail.contenturl               = model.url;// 网页链接
    
    [self.navigationController pushViewController:controllerTwoDetail animated:YES];
}

- (void)dealloc {

    [self.selectNetwoking cancleRequest];
}

#pragma mark - 手势
/**
 *  view已经显示 ,就把手势关闭
 *
 *  @param animated
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self enablePopGesture:NO];
}

/**
 *  view已经消失, 允许有侧滑的手势
 *
 *  @param animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self enablePopGesture:YES];
}

@end
