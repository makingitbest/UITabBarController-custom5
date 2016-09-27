//
//  CustomTableViewCell.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/24.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, weak) CellDataAdapter *dataAdapter;
@property (nonatomic, weak) NSIndexPath     *indexPath;
@property (nonatomic, weak) UITableView     *tableView;


/**
 *  设置cell的相关属性
 */
- (void)setUp;

/**
 *  cell的界面布局
 */
- (void)interfaceLayout;

/**
 *  cell上数据的加载
 *
 *  @param data 外部加载的数据
 */
- (void)loadData:(id)data;

@end
