//
//  WACityListViewModel.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WACityListViewModel : NSObject

@property (nonatomic, readonly) NSArray *cities;

- (instancetype)initWithCities:(NSArray *)cities;

- (NSArray *)filterWithCityName:(NSString *)cityName;

@end
