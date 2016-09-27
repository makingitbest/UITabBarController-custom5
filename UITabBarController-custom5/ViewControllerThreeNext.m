//
//  ViewControllerThreeNext.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/23.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewControllerThreeNext.h"
#import "Networking.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "SelectCell.h"
#import "SelectModel.h"
#import "MJRefresh.h"
#import "ViewControllerThreeNextDetail.h"

typedef enum : NSUInteger {
    
    kNormalRequest,
    kDownPullRefresh, // 下拉刷新
    kUpPullRefresh,  // 上拉加载
    
} EPullRefresh;

@interface ViewControllerThreeNext () <NetworkingDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Networking     *selectNetwoking;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *selectDataArray;
@property (nonatomic, strong) MBProgressHUD  *hud;
@property (nonatomic, strong) NSDictionary   *dictionary;
@property (nonatomic, strong) NSNumber       *offsetNum;

@end

@implementation ViewControllerThreeNext

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.selectDataArray = [NSMutableArray array];
    
    // 网络加载
    self.offsetNum  = @(0);
    self.dictionary = @{@"limit"     :@"6",
                         @"offset"    :self.offsetNum,
                         @"generation":@"1"
                         };
    
    self.selectNetwoking = [Networking networkingWithUrlString:@"http://api.chuandazhiapp.com/v2/channels/5/items"
                                              requestParameter:self.dictionary
                                                      delegate:self
                                                   requestBody:kHTTPBodyType
                                              responseDataType:kJSONResponseType
                                                 requestMethod:kGETMethodType];
    self.selectNetwoking.tag = kNormalRequest;
    [self.selectNetwoking startRequest];
    
    // 加载页
    self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.loadingView text:@"加载数据中..."];
    
    // 创建tableView
    self.tableView            = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerClass:[SelectCell class] forCellReuseIdentifier:@"SelectCell"];
    
    // 下拉刷新
   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
       [self loadNewData];
   }];
    
//    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
}

- (void)loadNewData {

    self.offsetNum  = @(0);
    self.dictionary = @{ @"limit"     :@"6",
                         @"offset"    :self.offsetNum,
                         @"generation":@"1"
                         };
    self.selectNetwoking.parameters = self.dictionary;
    self.selectNetwoking.tag        = kDownPullRefresh;
    
    [self.selectNetwoking startRequest];
}

- (void)loadMoreData {

    self.offsetNum   = @(self.offsetNum.integerValue + 6);
    
    self.dictionary  = @{ @"limit"     :@"6",
                          @"offset"    :self.offsetNum,
                          @"generation":@"1"
                           };
    self.selectNetwoking.parameters = self.dictionary;
    self.selectNetwoking.tag        = kUpPullRefresh;
    
    [self.selectNetwoking startRequest];
}

#pragma mark - networkingDelegate

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {
    
    [self.hud hideInLoadingView];
    
    if (networking.tag == kDownPullRefresh) {
        
        [self.tableView.mj_header endRefreshing];
        
        [self.selectDataArray removeAllObjects];
        
        NSMutableArray *array = data[@"data"][@"items"];
        for (NSDictionary *dic in array) {
            
            SelectModel *model = [[SelectModel alloc] initWithDictionary:dic];
            [self.selectDataArray insertObject:model atIndex:0];
        }

    } else if ( networking.tag == kUpPullRefresh) {
    
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *array = data[@"data"][@"items"];
        for (NSDictionary *dic in array) {
            
            SelectModel *model = [[SelectModel alloc] initWithDictionary:dic];
            [self.selectDataArray addObject:model];
        }
        
    } else if (  networking.tag == kNormalRequest){
        
        NSMutableArray *array = data[@"data"][@"items"];
        for (NSDictionary *dic in array) {
            
            SelectModel *model = [[SelectModel alloc] initWithDictionary:dic];
            [self.selectDataArray addObject:model];
        }
    }
        
    [self.tableView reloadData];
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {
    
    NSLog(@"%@", error);
    
    [self.hud hideInLoadingView];
    
    if (networking.tag == kDownPullRefresh) {
        
        [self.tableView.mj_header endRefreshing];
        
    } else if (networking.tag == kUpPullRefresh) {
    
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)dealloc {
    
    if (self.selectNetwoking.tag == kNormalRequest) {
        
        [self.selectNetwoking cancleRequest];
        
    } else if (self.selectNetwoking.tag == kDownPullRefresh) {
    
        [self.selectNetwoking cancleRequest];
        
    } else if (self.selectNetwoking.tag == kUpPullRefresh) {
    
        [self.selectNetwoking cancleRequest];
    }
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.selectDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCell"];
    SelectModel  *model      = self.selectDataArray[indexPath.row];
    [cell loadData:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SelectModel *model = self.selectDataArray[indexPath.row];
    
    ViewControllerThreeNextDetail *threeNextDetail = [[ViewControllerThreeNextDetail alloc] init];
    threeNextDetail.title                          = model.title;
    threeNextDetail.urlString                      = model.url;
    [self.navigationController pushViewController:threeNextDetail animated:YES];
}

@end
