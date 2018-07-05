//
//  WAForecast.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WAForecast.h"

@implementation WAForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _date = dictionary[@"date"] ?: @"Not Especified";
        _day = dictionary[@"day"] ?: @"Not Especified";
        _min = dictionary[@"low"] ?: @"Not Especified";
        _max = dictionary[@"high"] ?: @"Not Especified";
        _weatherDescription = dictionary[@"text"] ?: @"Not Especified";
    }
    
    return self;
}

@end
