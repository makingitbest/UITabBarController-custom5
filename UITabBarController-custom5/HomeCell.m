//
//  HomeCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/22.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "HomeCell.h"
#import "HomeModel.h"
#import "ActivityResultModel.h"
#import "UIView+SetRect.h"
#import "UIImageView+WebCache.h"

@interface HomeCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *createLabel;

@end

@implementation HomeCell

- (void)setUp {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {
    
    self.photoImageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.photoImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.photoImageView.layer.masksToBounds = YES;
    [self addSubview:self.photoImageView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, Width - 120, 40)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font          = [UIFont systemFontOfSize:13];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor     = [UIColor blackColor];
    [self addSubview:self.titleLabel];
    
    self.createLabel               = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, Width - 120, 40)];
    self.createLabel.textAlignment = NSTextAlignmentLeft;
    self.createLabel.font          = [UIFont systemFontOfSize:13];
    self.createLabel.numberOfLines = 0;
    self.createLabel.textColor     = [UIColor blackColor];
    [self addSubview:self.createLabel];
}

- (void)loadData:(id)data {
    
    ActivityResultModel *model = data;
    
    NSString *url     = @"http://hyzx.img-cn-beijing.aliyuncs.com";
    NSString *string  = [[NSString alloc] initWithFormat:@"%@%@",url,model.thumbnail];
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:string]];
    
    self.titleLabel.x    = 100;
    self.titleLabel.y    = 10;
    self.titleLabel.text = model.title;
    
    self.createLabel.y    = self.titleLabel.bottom + 5;
    self.createLabel.text = model.startTime;
}

@end
