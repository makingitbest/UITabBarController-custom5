//
//  HomeModel.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/22.
//  Copyright © 2016年 WangQiao. All rights reserved.
//
//  data {city:[],spaces:[[],[],[]]}

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property (nonatomic, strong) NSNumber *activityCount;
@property (nonatomic, strong) NSString *background;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSNumber *homeID;
@property (nonatomic ,strong) NSString *enCity;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray  *facilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
