//
//  ViewControllerOne.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerOne.h"
#import "ViewControllerOneNext.h"
#import "Networking.h"
#import "HomeModel.h"
#import "ActivityResultModel.h"
#import "HomeCell.h"
#import "ViewControllerOneToOne.h"
#import "GCD.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "ScrollViewCell.h"
#import "MJRefresh.h"
#import "CreateModel.h"

typedef enum : NSUInteger {
    
    kHomeRequestTag = 50,
    kRefreshData,
    kUpRefreshData,
    
} ENetRequestTag;

@interface ViewControllerOne () <NetworkingDelegate, UITableViewDelegate, UITableViewDataSource> {

    ScrollViewCell *_scrollViewCell;

}

@property (nonatomic, strong) Networking      *homeNetworking;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) MBProgressHUD   *hud;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) NSNumber *pageNum;

@end

@implementation ViewControllerOne

- (void)viewDidLoad {

    [super viewDidLoad];
        
    self.adapters = [NSMutableArray array];
    
    // 打开滑动手势
    [self useInteractivePopGestureRecognizer];
    
    // 更改navigationBar
    [self changeNavigationBar];
    
    // 加载页
    self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.loadingView text:@"加载数据中..."];
    
    // 网络请求数据
    self.pageNum = @(1);
    self.homeNetworking    = [Networking networkingWithUrlString:@"http://act.techcode.com/api/activity/latest"
                                                requestParameter:@{
                                                                   @"auth_token":@"",
                                                                   @"city"      :@"",
                                                                   @"maxResults":@"20",
                                                                   @"pn"        :self.pageNum,
                                                                   @"sort"      :@"newest",
                                                                   @"type"      :@"0"
                                                                   }
                                                     delegate:self
                                                  requestBody:kHTTPBodyType
                                             responseDataType:kHTTPResponseType
                                                requestMethod:kPOSTMethodType];
    self.homeNetworking.tag = kHomeRequestTag;
    [self.homeNetworking startRequest];
    
    // 创建tableView
    [self createTableView];
    
    // 添加两个cell ,另一个在下面
    [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ScrollViewCell" data:nil cellHeight:180 cellType:0]];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
}

#pragma mark - refresh
- (void)loadNewData {

    self.pageNum            = @(1);
    self.homeNetworking.tag = kRefreshData;
    [self.homeNetworking startRequest];
    
    [_scrollViewCell startRequestData];
}

- (void)loadMoreData {

    self.pageNum            = @(self.pageNum.integerValue + 1);
    self.homeNetworking.tag = kUpRefreshData;
    [self.homeNetworking startRequest];
}

#pragma  mark - create tableView

- (void)createTableView {

    self.tableView            = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    [self.tableView registerClass:[ScrollViewCell class] forCellReuseIdentifier:@"ScrollViewCell"];
}

#pragma mark  - 网络请求

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {
    
    [self.hud hideInLoadingView];
    
    if (networking.tag == kHomeRequestTag) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *array = dic[@"data"][@"results"];
        
        for (NSDictionary *dic in array) {
            
            ActivityResultModel *model = [[ActivityResultModel alloc] initWithDictionary:dic];
            
            [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"HomeCell" data:model cellHeight:100 cellType:0]];
        }
        
        [self.tableView reloadData];
        
    } else if (networking.tag == kRefreshData) {
    
        [self.tableView.mj_header endRefreshing];
        [self.adapters removeObjectsInRange:NSMakeRange(1, self.adapters.count - 1)];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *array = dic[@"data"][@"results"];
        
        for (NSDictionary *dic in array) {
            
            ActivityResultModel *model = [[ActivityResultModel alloc] initWithDictionary:dic];
            
            [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"HomeCell" data:model cellHeight:100 cellType:0]];
        }
        
        [self.tableView reloadData];
    
    } else if (networking.tag == kUpRefreshData) {
    
        [self.tableView.mj_footer endRefreshing];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *array = dic[@"data"][@"results"];
        
        for (NSDictionary *dic in array) {
            
            ActivityResultModel *model = [[ActivityResultModel alloc] initWithDictionary:dic];
            
            [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"HomeCell" data:model cellHeight:100 cellType:0]];
        }
    
        [self.tableView reloadData];
    }
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {
    
    [self.hud hideInLoadingView];
    [self.tableView.mj_header endRefreshing];
    
    NSLog(@"homeNetworking error :%@",error);
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.reusedIdentifier];
    cell.dataAdapter          = adapter;
    cell.indexPath            = indexPath;
    [cell loadData:adapter.data];
    
    // 仅仅调用一次
    if (_scrollViewCell == nil && indexPath.row == 0) {
        
        _scrollViewCell = (ScrollViewCell *)cell;
        [_scrollViewCell startRequestData];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[HomeCell class]]) {
        
        ActivityResultModel  *model = self.adapters[indexPath.row].data;
        
        ViewControllerOneNext *oneNext   = [[ViewControllerOneNext alloc] init];
        oneNext.detailID                 = model.ActivityID;
        oneNext.loveCity                 = model.city;
        oneNext.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:oneNext animated:YES];
    }
}

- (void)dealloc {

    if (self.homeNetworking.tag == kRefreshData) {
        
        [self.homeNetworking cancleRequest];

    } else if (self.homeNetworking.tag == kUpRefreshData) {
    
        [self.homeNetworking cancleRequest];
    
    }
}

#pragma mark - 更改导航栏设置

- (void)changeNavigationBar {
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UILabel class]]) {
            
            UILabel *tmp  = obj;
            tmp.textColor = [UIColor purpleColor];
        }
        
        if ([obj isKindOfClass:[UIButton class]]) {
            
            UIButton *button = obj;
            button.hidden    = YES;
        }
    }];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.screenWidth - 60, 20, 40, 44)];
    [button setImage:[UIImage imageNamed:@"Search Icon Copy"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:button];
}

- (void)buttonClick:(UIButton *)button {

    ViewControllerOneToOne *oneToOne = [[ViewControllerOneToOne alloc] init];
    [self.navigationController pushViewController:oneToOne animated:YES];
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
