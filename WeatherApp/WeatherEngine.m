//
//  WeatherEngine.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WeatherEngine.h"
#import "WACity.h"
#import "WAForecast.h"
#import "WACityViewModel.h"
#import "WAForecastViewModel.h"

#define WEATHER_API_PREFIX @"https://query.yahooapis.com/v1/public/yql?q="
#define WEATHER_API_QUERY @"select item.forecast from weather.forecast where woeid in (select woeid from geo.places(1) where text='%@')"
#define WEATHER_API_SUFIX @"&format=json"

#define CITIES_FILE @"USCities"

@implementation WeatherEngine

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.URLSession = [NSURLSession sharedSession];
    }
    
    return self;
}

- (NSString *)fileName {
    return CITIES_FILE;
}

- (NSArray *)getAllCities {
    
    NSURL *urlForFile = [[NSBundle mainBundle] URLForResource:[self fileName] withExtension:@"json"];
    
    if (!urlForFile) {
        return @[];
    }
    
    NSError *error;
    NSData *dataFile = [NSData dataWithContentsOfURL:urlForFile options:0 error:&error];
    
    NSMutableArray *cities = [NSMutableArray array];
    if (!error) {
        error = nil;
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:dataFile options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"ERROR: %@", [error localizedDescription]);
        }else {
            
            for (NSDictionary *dicto in (NSArray *)json) {
                
                WACity *city = [[WACity alloc] initWithDictionary:dicto];
                
                WACityViewModel *cityModel = [[WACityViewModel alloc] initWithCity:city];
                [cities addObject:cityModel];
            }
        }
    }
    
    return cities;
}

- (void)getForecastForCity:(NSString *)city doOnSuccess:(void (^)(NSArray *forecasts))success doOnFailure:(void(^)(NSError * error))failure {
    
    NSString *escapedQuery = [[NSString stringWithFormat:WEATHER_API_QUERY, city] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",WEATHER_API_PREFIX, escapedQuery, WEATHER_API_SUFIX]];
    
    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [self.URLSession dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                //NSLog(@"%@",data);
                                                if (error)
                                                    failure(error);
                                                else {
                                                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSLog(@"%@",responseString);
                                                    
                                                    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                    NSLog(@"%@",json);
                                                    
                                                    NSMutableArray *casts = [NSMutableArray array];
                                                    
                                                    NSArray *items = json[@"query"][@"results"][@"channel"];
                                                    //NSLog(@"ITEMS: %@",items);
                                                    for (NSDictionary *item in items) {
                                                        NSDictionary *data = item[@"item"][@"forecast"];
                                                        
                                                        WAForecast *forecast = [[WAForecast alloc] initWithDictionary:data];
                                                        WAForecastViewModel *model = [[WAForecastViewModel alloc] initWithForecast:forecast];
                                                        
                                                        [casts addObject:model];
                                                    }
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        success(casts);
                                                    });
                                                    
                                                }
                                            }];
    [dataTask resume];    // Executed First
}

@end
