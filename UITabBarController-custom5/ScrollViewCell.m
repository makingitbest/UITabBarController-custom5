//
//  ScrollViewCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/24.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ScrollViewCell.h"
#import "Networking.h"
#import "UIImageView+WebCache.h"
#import "UIView+SetRect.h"
#import "SlideListModel.h"

typedef enum : NSUInteger {
    
    kImageViewTag = 20,
    
} EImageViewTag;

@interface ScrollViewCell () <UIScrollViewDelegate, NetworkingDelegate> {

    NSInteger imageCount;
}

@property (nonatomic, strong) UIScrollView    *scrollView;
@property (nonatomic, strong) NSMutableArray  *imageArray;
@property (nonatomic, strong) Networking      *scrollNetworking;
@property (nonatomic, strong) UIImageView     *iconImageView;

@end

@implementation ScrollViewCell

- (void)setUp {
   
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imageArray = [NSMutableArray array];

    self.scrollView                                = [[UIScrollView  alloc] initWithFrame:CGRectMake(0, 0, Width, 180)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces                        = NO;
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.delegate                       = self;
    
    [self addSubview:self.scrollView];
}

- (void)startRequestData{
    
    // 网络请求
    self.scrollNetworking = [Networking networkingWithUrlString:@"http://act.techcode.com/api/slide/list"
                                               requestParameter:nil
                                                       delegate:self
                                                    requestBody:kHTTPBodyType
                                               responseDataType:kHTTPResponseType
                                                  requestMethod:kPOSTMethodType];
    [self.scrollNetworking startRequest];
}

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *array = dic[@"data"];

    [self.imageArray removeAllObjects]; // 这里需要把所有的数据移除
    
    for (NSDictionary *dic  in array) {
        
        SlideListModel *model = [[SlideListModel alloc] initWithDictionary:dic];
        
        [self.imageArray addObject:model];
    }
    
    if (imageCount > 0) {
        
        for (int i = 0; i < imageCount; i ++) {
            
            [[self.scrollView viewWithTag:kImageViewTag + i] removeFromSuperview];
        }
    }
    
    imageCount = self.imageArray.count;
    
    for (int i = 0; i < self.imageArray.count; i++) {
        
        SlideListModel *model = self.imageArray[i];
        
        NSString *url     = @"http://hyzx.img-cn-beijing.aliyuncs.com";
        NSString *string  = [[NSString alloc] initWithFormat:@"%@%@",url,model.thumbnail];
        
        self.iconImageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(Width * i, 0, Width, 180)];
        self.iconImageView.contentMode         = UIViewContentModeScaleAspectFill;
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.tag                 = kImageViewTag + i;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:string]];
        [self.scrollView addSubview:self.iconImageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(Width * self.imageArray.count, 180);
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {

    NSLog(@"error = %@",error);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

@end
