//
//  WACityListViewModel.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WACityListViewModel.h"

@interface WACityListViewModel ()

@end

@implementation WACityListViewModel

- (instancetype)initWithCities:(NSArray *)cities {
    
    self = [super init];
    if (self) {
        _cities = cities ?: @[];
    }
    
    return self;
}

- (NSArray *)filterWithCityName:(NSString *)cityName {
    
    if (!cityName || [cityName isEqualToString:@""]) {
        return @[];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city.city CONTAINS[c] %@", cityName];
    NSArray *filteredCities = [self.cities filteredArrayUsingPredicate:predicate];
    
    return filteredCities;
}

@end
