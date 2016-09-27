//
//  ViewControllerFourNext.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/25.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerFourNext.h"
#import "Networking.h"
#import "CellDataAdapter.h"
#import "ActivityResultModel.h"
#import "HomeCell.h"
#import "ScrollViewCell.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "MJRefresh.h"

typedef enum : NSUInteger {
    
    kNormalRequestTag = 30,
    kDownRefreshTag,
    kUpRefreshTag,

} ERequestTag;

@interface ViewControllerFourNext () <NetworkingDelegate, UITableViewDelegate, UITableViewDataSource>  {

    ScrollViewCell * _scrollViewCell;

}

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) Networking                         *networking;
@property (nonatomic, strong) NSNumber                           *pageNum;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) MBProgressHUD                      *hud;

@end

@implementation ViewControllerFourNext

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.adapters = [NSMutableArray array];
    
    self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.loadingView text:@"正在努力加载....."];
    
    self.pageNum    = @(1);
    self.networking = [Networking networkingWithUrlString:@"http://act.techcode.com/api/activity/latest"
                                         requestParameter:@{@"auth_token":@"",
                                                            @"city"      :@"",
                                                            @"maxResults":@"20",
                                                            @"pn"        :self.pageNum,
                                                            @"sort"      :@"newest",
                                                            @"type"      :@"0"}
                                                 delegate:self
                                              requestBody:kHTTPBodyType
                                         responseDataType:kHTTPResponseType
                                            requestMethod:kPOSTMethodType];
    self.networking.tag  = kNormalRequestTag;
    [self.networking startRequest];
    
    [self createTableView];
    
    [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ScrollViewCell" data:nil cellHeight:180 cellType:0]];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
}

- (void)loadNewData {

    self.pageNum        = @(1);
    self.networking.tag = kDownRefreshTag;
    [self.networking startRequest];
    
    [_scrollViewCell startRequestData];
}

- (void)loadMoreData {
    
    self.pageNum        = @(self.pageNum.integerValue + 1);
    self.networking.tag = kUpRefreshTag;
    [self.networking startRequest];
}

- (void)createTableView {

    self.tableView            = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    [self.tableView registerClass:[ScrollViewCell class] forCellReuseIdentifier:@"ScrollViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CellDataAdapter *adapter  = self.adapters[indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.reusedIdentifier];
    cell.dataAdapter          = adapter;
    cell.indexPath            = indexPath;
    [cell loadData:adapter.data];

    if (_scrollViewCell == nil && indexPath.row == 0) {
    
        _scrollViewCell = (ScrollViewCell *)cell;
        [_scrollViewCell startRequestData];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.adapters[indexPath.row].cellHeight;
}

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {
    
    [self.hud hideInLoadingView];
    
    if (networking.tag == kNormalRequestTag) {
                
        NSDictionary *dic     = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array = dic[@"data"][@"results"];
        for (NSDictionary *dic in array) {
            
            ActivityResultModel *model = [[ActivityResultModel alloc] initWithDictionary:dic];
            
            [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"HomeCell" data:model cellHeight:100 cellType:0]];
        }
        
        [self.tableView reloadData];
        
    } else if (networking.tag == kDownRefreshTag) {
    
        [self.tableView.mj_header endRefreshing];
        
        [self.adapters removeObjectsInRange:NSMakeRange(1, self.adapters.count - 1)];
        
        NSDictionary *dic     = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array = dic[@"data"][@"results"];
        for (NSDictionary *dic in array) {
            
            ActivityResultModel *model = [[ActivityResultModel alloc] initWithDictionary:dic];
            
            [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"HomeCell" data:model cellHeight:100 cellType:0]];
        }
        
        [self.tableView reloadData];
    
    } else if (networking.tag == kUpRefreshTag) {
    
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
    
    if (networking.tag == kDownRefreshTag) {
        
        [self.tableView.mj_header endRefreshing];
        
    } else if (networking.tag == kUpRefreshTag) {
    
        [self.tableView.mj_footer endRefreshing];
    }
}

@end
