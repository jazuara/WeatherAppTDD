//
//  WAForecast.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAForecast : NSObject

@property (nonatomic, readonly) NSString *date;
@property (nonatomic, readonly) NSString *day;
@property (nonatomic, readonly) NSString *max;
@property (nonatomic, readonly) NSString *min;
@property (nonatomic, readonly) NSString *weatherDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
