//
//  WACityViewModel.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WACityViewModel.h"
#import "WACityTableViewCell.h"

@implementation WACityViewModel

- (instancetype)initWithCity:(WACity *)city {
    self = [super init];
    if (self) {
        _city = city;
        if (_city) {
            _weatherModel = [[WACityWeatherViewModel alloc] initWithCity:_city];
        }
    }
    
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    WACityTableViewCell *cell = (WACityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WACityViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.city.city;
    cell.detailTextLabel.text = self.city.state;
    
    return cell;
}

- (CGFloat)rowHeight {
    return 60.0;
}

@end
