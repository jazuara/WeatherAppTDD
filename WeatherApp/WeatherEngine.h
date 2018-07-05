//
//  WeatherEngine.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherEngine : NSObject

@property (nonatomic, strong) NSURLSession *URLSession;

- (NSArray *)getAllCities;
- (void)getForecastForCity:(NSString *)city doOnSuccess:(void (^)(NSArray *forecasts))success doOnFailure:(void(^)(NSError * error))failure;

@end
