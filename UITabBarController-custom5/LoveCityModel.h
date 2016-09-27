//
//  LoveCityModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//


#import <Foundation/Foundation.h>

@interface LoveCityModel : NSObject

@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSNumber *source;
@property (nonatomic, strong) NSNumber *liveId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *applyStatus;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *visits;
// @property (nonatomic, strong) Null *region;
@property (nonatomic, strong) NSNumber *liveStatus;
@property (nonatomic, strong) NSNumber *applicants;
@property (nonatomic, strong) NSString *organizer;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *contacter;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *sourceUrl;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *audit;
@property (nonatomic, strong) NSString *liveUrl;
@property (nonatomic, strong) NSNumber *dimensions;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *favoriteStatus;

/**
 *  Init the model with dictionary
 *
 *  @param dictionary dictionary
 *
 *  @return model
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

