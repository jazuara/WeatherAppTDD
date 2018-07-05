//
//  WACityWeatherViewModel.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WACityWeatherViewModel.h"
#import "WeatherEngine.h"

@implementation WACityWeatherViewModel

- (instancetype)initWithCity:(WACity *)city {
    self = [super init];
    if (self) {
        _city = city;
        _engine = [[WeatherEngine alloc] init];
    }
    
    return self;
}

- (void)getForecastDoOnSuccess:(void (^)(NSString *cityQuery, NSArray *forecasts))success doOnFailure:(void(^)(NSError * error))failure {
    
    NSString *query = [NSString stringWithFormat:@"%@, %@", self.city.city, self.city.state];
    [self.engine getForecastForCity:query doOnSuccess:^(NSArray *forecasts) {
        success(query, forecasts);
    } doOnFailure:^(NSError *error) {
        failure(error);
    }];
}

@end
