//
//  WAWeatherViewController.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WAWeatherViewController.h"
#import "WAForecastViewModel.h"

@interface WAWeatherViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation WAWeatherViewController

- (instancetype)initWithForecasts:(NSArray *)data {
    
    self = [super initWithNibName:@"WAWeatherViewController" bundle:nil];
    if (self) {
        self.data = data;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNIB = [UINib nibWithNibName:@"WAForecastTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNIB forCellReuseIdentifier:@"WAForecastTableViewCell"];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WAForecastViewModel *model = self.data[indexPath.row];
    return [model cellForTableView:tableView indexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(WAForecastViewModel *)self.data[indexPath.row] rowHeight];
}

@end
