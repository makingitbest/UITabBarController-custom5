//
//  ActivityDetailHeaderCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/26.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ActivityDetailHeaderCell.h"
#import "UIView+SetRect.h"
#import "ActivityDetailModel.h"
#import "UIImageView+WebCache.h"

@interface ActivityDetailHeaderCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation ActivityDetailHeaderCell

- (void)setUp {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {
    
    self.headerImageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 180)];
    self.headerImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.headerImageView.layer.masksToBounds = YES;
    [self addSubview:self.headerImageView];
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 179.5, Width, 0.5)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.lineView];
}

- (void)loadData:(id)data {
    
    ActivityDetailModel *model = data;
    
    NSString *url     = @"http://hyzx.img-cn-beijing.aliyuncs.com";
    NSString *string  = [[NSString alloc] initWithFormat:@"%@%@",url,model.thumbnail];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:string]];
}

@end
