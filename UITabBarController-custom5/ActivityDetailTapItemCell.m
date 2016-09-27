//
//  ActivityDetailTapItemCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/26.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ActivityDetailTapItemCell.h"
#import "UIView+SetRect.h"
#import "NSString+LabelWidthAndHeight.h"

@interface ActivityDetailTapItemCell ()

@property (nonatomic, strong) UILabel *tapItemLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation ActivityDetailTapItemCell

- (void)setUp {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {

    self.tapItemLabel               = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 45)];
    self.tapItemLabel.font          = [UIFont systemFontOfSize:12];
    self.tapItemLabel.textAlignment = NSTextAlignmentLeft;
    self.tapItemLabel.numberOfLines = 0;
    [self addSubview:self.tapItemLabel];
    
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, Width, 0.5)];
    self.lineView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.lineView];
}

- (void)loadData:(id)data {
    
    ActivityDetailModel *model = data;
    
    if (self.dataAdapter.cellType == kTimeItemType) {
        
        NSString *startTime  = [model.startTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *endTime    = [model.endTime stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString *timeString = nil;
        if (startTime.length >= 10 && endTime.length >= 10 && [[startTime substringToIndex:10] isEqualToString:[endTime substringToIndex:10]]) {
            
            timeString = [NSString stringWithFormat:@"%@ - %@",startTime, [endTime substringWithRange:NSMakeRange(endTime.length - 5, 5)]];
            
        } else {
        
            timeString = [NSString stringWithFormat:@"%@ - %@" ,startTime , endTime];
        }
        
        self.tapItemLabel.text = timeString;
        self.lineView.x        = 20;
        self.lineView.width    = Width - 20;
        
    } else if (self.dataAdapter.cellType == kAddressItemType) {
    
        self.tapItemLabel.text = model.address;
        self.lineView.x        = 20;
        self.lineView.width    = Width - 20;
        self.lineView.y        = self.tapItemLabel.bottom;
    
    } else if (self.dataAdapter.cellType == kNumItemType) {
    
        self.tapItemLabel.text = [NSString stringWithFormat:@"练习主办方 %@",model.telephone];
        self.lineView.x        = 0;
        self.lineView.width    = Width;
    }
}

+ (CGFloat)cellHeightWithActivityModel:(ActivityDetailModel *)model {
    
    CGFloat realHeight = [model.address heightWithStringAttribute:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} fixedWidth:Width - 40];
    
    return realHeight;
}

@end
