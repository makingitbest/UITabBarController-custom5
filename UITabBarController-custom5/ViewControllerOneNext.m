//
//  ViewControllerOneNext.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/20.
//  Copyright © 2016年 WangQiao. All rights reserved.
//


#import "ViewControllerOneNext.h"
#import "ViewControllerOneNextOne.h"
#import "GCD.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Convenience.h"
#import "UIImageView+WebCache.h"
#import "Networking.h"
#import "CreateModel.h"
#import "CellDataAdapter.h"
#import "ActivityDetailHeaderCell.h"
#import "ActivityDetailTapItemCell.h"
#import "ActivityDetailContentCell.h"
#import "ActivityLoveCityCell.h"
#import "ActivityDetailModel.h"
#import "LoveCityModel.h"
#import "GCD.h"


typedef enum : NSUInteger {
    
    kDetailNetworkingTag = 20,
    kLoveCityNetworkingTag,
    
} ENetwrokingTag;

@interface ViewControllerOneNext () <NetworkingDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Networking                         *detailNetworking;
@property (nonatomic, strong) Networking                         *loveCityNetworking;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) ActivityDetailModel *activityDetailmodel;

@property (nonatomic, strong)  NSMutableArray  *loveCityDatas;;

@property (nonatomic, strong) GCDSemaphore *semaphore;

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ViewControllerOneNext

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self createNavigationBarItem];
    
    self.adapters      = [NSMutableArray array];
    self.loveCityDatas = [NSMutableArray array];
    
    self.hud = [MBProgressHUD showHUDAddedToLoadingView:self.windowView text:@"正在加载中....."];
    
    NSString     *datailString = @"http://act.techcode.com/api/activity/view";
    NSDictionary *datailDic    = @{@"auth_token":@"",@"id":self.detailID};
    self.detailNetworking      = [Networking networkingWithUrlString:datailString
                                                    requestParameter:datailDic
                                                            delegate:self
                                                         requestBody:kHTTPBodyType
                                                    responseDataType:kHTTPResponseType
                                                       requestMethod:kPOSTMethodType];
    self.detailNetworking.tag  = kDetailNetworkingTag;
    [self.detailNetworking startRequest];
    
    
    NSString     *loveCityString = @"http://act.techcode.com/api/activity/relatives";
    NSDictionary *loveCityDic    = @{@"city":self.loveCity,@"id":self.detailID};
    self.loveCityNetworking      = [Networking networkingWithUrlString:loveCityString
                                                      requestParameter:loveCityDic
                                                              delegate:self
                                                           requestBody:kHTTPBodyType
                                                      responseDataType:kHTTPResponseType
                                                         requestMethod:kPOSTMethodType];
    self.loveCityNetworking.tag  = kLoveCityNetworkingTag;
    [self.loveCityNetworking startRequest];
    
    
    [self createTableView];
    
    // 信号量
    self.semaphore = [GCDSemaphore new];
    [GCDQueue executeInGlobalQueue:^{
        
        [self.semaphore wait];
        [self.semaphore wait];
        
        [GCDQueue executeInMainQueue:^{
            
            [self createDataSource];
            [self createLoveCityDataSource];
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - tableView

- (void)createTableView {

    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    [self.contentView addSubview:self.tableView];
    
    [self.tableView registerClass:[ActivityDetailHeaderCell class]  forCellReuseIdentifier:@"ActivityDetailHeaderCell"];
    [self.tableView registerClass:[ActivityDetailTapItemCell class] forCellReuseIdentifier:@"ActivityDetailTapItemCell"];
    [self.tableView registerClass:[ActivityDetailContentCell class] forCellReuseIdentifier:@"ActivityDetailContentCell"];
    [self.tableView registerClass:[ActivityLoveCityCell class]      forCellReuseIdentifier:@"ActivityLoveCityCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CellDataAdapter *adapter  = self.adapters[indexPath.row];
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.reusedIdentifier];
    cell.dataAdapter          = adapter;
    cell.indexPath            = indexPath;
    cell.tableView            = tableView;
    [cell loadData:adapter.data];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.adapters[indexPath.row].cellHeight;
}

#pragma mark - createNavigationBarItem

-(void)createNavigationBarItem {

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 44)];
//    backButton.backgroundColor = [UIColor greenColor];
    [backButton setImage :[UIImage imageNamed:@"back_b"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:backButton];

}

#pragma mark - 数据请求

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {

    [self.hud hideInLoadingView];

    [self.semaphore signal];
    
    if (networking.tag == kDetailNetworkingTag) {
        
        NSLog(@"kDetailNetworkingTag");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dictionary = dic[@"data"];
        
        self.activityDetailmodel = [[ActivityDetailModel alloc] initWithDictionary:dictionary];
        
//        [self createDataSource];
//    
//        [self.tableView reloadData];

    }
    
    if (networking.tag == kLoveCityNetworkingTag) {
        
        NSLog(@"kLoveCityNetworkingTag");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            
            LoveCityModel *model = [[LoveCityModel alloc] initWithDictionary:dic];
            [self.loveCityDatas addObject:model];
            
//            [self createLoveCityDataSource];
        }
        
    }
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {
    
    [self.hud hideInLoadingView];
    
    [self.semaphore signal];
    
    if (networking.tag == kDetailNetworkingTag) {
    
        NSLog(@"DetailNetworking error : %@",error);
    }
    
    if (networking.tag == kLoveCityNetworkingTag) {
        
        NSLog(@"LoveCityNetworking error : %@",error);
    }
}

- (void)createDataSource {

    [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityDetailHeaderCell" data:self.activityDetailmodel cellHeight:180 cellType:0]];
    
    [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityDetailTapItemCell" data:self.activityDetailmodel cellHeight:45 cellType:kTimeItemType]];
    
    {
        CGFloat height = [ActivityDetailTapItemCell cellHeightWithActivityModel:self.activityDetailmodel];
        
        if (height > 45) {
            
            height = [ActivityDetailTapItemCell cellHeightWithActivityModel:self.activityDetailmodel];
            
        } else {
        
            height = 45;
        }
        
        [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityDetailTapItemCell" data:self.activityDetailmodel cellHeight:height cellType:kAddressItemType]];
    }
    
     [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityDetailTapItemCell" data:self.activityDetailmodel cellHeight:45 cellType:kNumItemType]];
    
    [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityDetailContentCell" data:self.activityDetailmodel cellHeight:1 cellType:0]];
}

- (void)createLoveCityDataSource {
    
    if (self.loveCityDatas.count) {
        
//        NSInteger count = self.adapters.count;
        
        for (int i = 0; i < self.loveCityDatas.count; i++) {
          
            LoveCityModel *model = self.loveCityDatas[i];
            
             [self.adapters addObject:[CellDataAdapter cellDataAdapter:@"ActivityLoveCityCell" data:model cellHeight:100 cellType:0]];
        }
        
    }
    
}

- (void)dealloc {

    [self.detailNetworking cancleRequest];
    
    [self.loveCityNetworking cancleRequest];
}

@end
