//
//  SlideListModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SlideListModel : NSObject

@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, strong) NSNumber *location;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSNumber *slideId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *created;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSNumber *type;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

