//
//  CustomTableViewCell.m
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/24.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUp];
        
        [self interfaceLayout];
        
    }
    
    return self;
}

- (void)setUp {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)interfaceLayout {
    
}

- (void)loadData:(id)data {
    
}

@end
