//
//  WACityViewModel.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellRepresentable.h"
#import "WACity.h"
#import "WACityWeatherViewModel.h"

@interface WACityViewModel : NSObject <UITableViewCellRepresentable>

@property (nonatomic, readonly) WACity *city;
@property (nonatomic, readonly) WACityWeatherViewModel *weatherModel;

- (instancetype)initWithCity:(WACity *)city;

@end
