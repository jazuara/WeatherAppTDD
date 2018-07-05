//
//  WAForecastViewModel.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WAForecastViewModel.h"
#import "WAForecastTableViewCell.h"

@implementation WAForecastViewModel

- (instancetype)initWithForecast:(WAForecast *)forecast {
    self = [super init];
    if (self) {
        _forecast = forecast;
    }
    
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    WAForecastTableViewCell *cell = (WAForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WAForecastTableViewCell" forIndexPath:indexPath];
    
    cell.lblDay.text = self.forecast.day;
    cell.lblMax.text = self.forecast.max;
    cell.lblMin.text = self.forecast.min;
    cell.lblDate.text = self.forecast.date;
    cell.lblDescription.text = self.forecast.weatherDescription;
    
    return cell;
}

- (CGFloat)rowHeight {
    return 120.0;
}

@end
