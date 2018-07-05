//
//  WACity.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WACity.h"

@implementation WACity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _city = dictionary[@"city"] ?: @"No City Name Given";
        _state = dictionary[@"state"] ?: @"No State Name Given";
    }
    
    return self;
}

@end
