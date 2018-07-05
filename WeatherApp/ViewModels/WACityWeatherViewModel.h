//
//  WACityWeatherViewModel.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WACity.h"
#import "WeatherEngine.h"

@interface WACityWeatherViewModel : NSObject 

@property (nonatomic, readonly) WeatherEngine *engine;
@property (nonatomic, readonly) WACity *city;
@property (nonatomic, readonly) NSArray *forecast; //An array of WAForecast objects

- (instancetype)initWithCity:(WACity *)city;
- (void)getForecastDoOnSuccess:(void (^)(NSString *cityQuery, NSArray *forecasts))success doOnFailure:(void(^)(NSError * error))failure;

@end
