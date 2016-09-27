//
//  SelectModel.h
//  UITabBarController-custom5
//
//  Created by WangQiao on 16/8/22.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectModel : NSObject

@property (nonatomic, strong) NSString * content_url;//图片
@property (nonatomic, strong) NSString * cover_image_url;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * selectId;
@property (nonatomic, strong) NSArray  * labels;
@property (nonatomic, strong) NSString * liked;
@property (nonatomic, strong) NSNumber * likes_count;//喜爱次数
@property (nonatomic, strong) NSString * published_at;//发布时间
@property (nonatomic, strong) NSString * share_msg;
@property (nonatomic, strong) NSString * short_title;
@property (nonatomic, strong) NSNumber * status;
@property (nonatomic, strong) NSString * title ;//标题
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSNumber * updated_at;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * editor_id;
@property (nonatomic, strong) NSString * template;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
