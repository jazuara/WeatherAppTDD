//
//  MockWeatherEngine.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "MockWeatherEngine.h"

#define CITIES_FILE @"mockUSCities"

@implementation MockWeatherEngine

- (NSString *)fileName {
    return self.filePath != nil ? self.filePath : @"mockUSCities";
}

@end
