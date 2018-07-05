//
//  WAWeatherViewController.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAWeatherViewController : UITableViewController

- (instancetype)initWithForecasts:(NSArray *)data;

@end
