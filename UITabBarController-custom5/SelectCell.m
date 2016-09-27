//
//  SelectCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/22.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "SelectCell.h"
#import "SelectModel.h"
#import "UIImageView+WebCache.h" 
#import "UIView+SetRect.h"
#import "HexColors.h"

@interface SelectCell ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *likeCountLabel;
@property (nonatomic, strong) UILabel     *discripLabel;

@end

@implementation SelectCell

- (void)setUp {

    self.selectionStyle  = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {
    
    self.backImageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 150)];
    self.backImageView.contentMode         = UIViewContentModeScaleAspectFill;
    self.backImageView.layer.masksToBounds = YES;
    [self addSubview:self.backImageView];
    
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, Width - 30, 44)];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor     = [UIColor colorWithHexString:@"e7d999" alpha:1];
    self.titleLabel.font          = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.likeCountLabel               = [[UILabel alloc] initWithFrame:CGRectMake(Width - 60, 100, 50, 50)];
    self.likeCountLabel.textAlignment = NSTextAlignmentCenter;
    self.likeCountLabel.textColor     = [UIColor redColor];
    self.likeCountLabel.font          = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.likeCountLabel];
    
    self.discripLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, Width, 44)];
    self.discripLabel.numberOfLines = 2;
    self.discripLabel.textColor     = [UIColor colorWithHexString:@"6fbfb3" alpha:0.9];
    self.discripLabel.font          = [UIFont systemFontOfSize:12];
    self.discripLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.discripLabel];
    

}

- (void)loadData:(id)data {
    
    SelectModel *model = data;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url]];
    
    self.titleLabel.text = model.title;
    
    self.discripLabel.text = model.share_msg;
    
    self.likeCountLabel.text = [model.likes_count stringValue];
}

@end
