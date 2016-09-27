//
//  ActivityResultModel.h
//
//  http://www.cnblogs.com/YouXianMing/
//  https://github.com/YouXianMing
//
//  Copyright (c) YouXianMing All rights reserved.
//address = "\U671d\U9633\U8def35\U53f7\U94ed\U57fa\U56fd\U9645\U521b\U610f\U516c\U56edA1";

#import <Foundation/Foundation.h>

@interface ActivityResultModel : NSObject

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
@property (nonatomic, strong) NSNumber *ActivityID;
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

