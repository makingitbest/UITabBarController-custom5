//
//  ActivityDetailTapItemCell.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/26.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "ActivityDetailModel.h"

typedef enum : NSUInteger {
    
    kTimeItemType,
    kAddressItemType,
    kNumItemType,
    
} EItemType;

@interface ActivityDetailTapItemCell : CustomTableViewCell

+ (CGFloat)cellHeightWithActivityModel:(ActivityDetailModel *)model;

@end
