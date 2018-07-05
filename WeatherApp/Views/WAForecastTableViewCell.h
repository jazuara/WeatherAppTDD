//
//  WAForecastTableViewCell.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAForecastTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblDay;
@property (nonatomic, weak) IBOutlet UILabel *lblMax;
@property (nonatomic, weak) IBOutlet UILabel *lblMin;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;
@property (nonatomic, weak) IBOutlet UILabel *lblDate;

@end
