//
//  WAForecastViewModel.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellRepresentable.h"
#import "WAForecast.h"

@interface WAForecastViewModel : NSObject <UITableViewCellRepresentable>

@property (nonatomic, readonly) WAForecast *forecast;

- (instancetype)initWithForecast:(WAForecast *)forecast;

@end
