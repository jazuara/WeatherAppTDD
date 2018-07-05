//
//  WACitiesViewController.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "WACitiesViewController.h"
#import "WAWeatherViewController.h"
#import "WACityWeatherViewModel.h"

@interface WACitiesViewController ()

@property (nonatomic) BOOL resetSearch;

@end

@implementation WACitiesViewController

- (instancetype)initWithModel:(WACityListViewModel *)model {
    
    self = [super initWithNibName:@"WACitiesViewController" bundle:nil];
    if (self) {
        _cityListModel = model;
        _cities = [model cities];
        self.resetSearch = true;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Select a City";
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    
    UINib *cellNIB = [UINib nibWithNibName:@"WACityTableViewCell" bundle:nil];
    [self.tblCities registerNib:cellNIB forCellReuseIdentifier:@"WACityViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WACityViewModel *model = self.cities[indexPath.row];
    return [model cellForTableView:tableView indexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(WACityViewModel *)self.cities[indexPath.row] rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WACityViewModel *cityModel = self.cities[indexPath.row];
    
    //Originally, I had it like this but it was not unit test friendly in order to replace the engine property with my mock
    //WACityWeatherViewModel *cityWeatherModel = [[WACityWeatherViewModel alloc] initWithCity:cityModel.city];
    [cityModel.weatherModel getForecastDoOnSuccess:^(NSString *query, NSArray *forecasts) {
        WAWeatherViewController *controller = [[WAWeatherViewController alloc] initWithForecasts:forecasts];
        controller.title = query;
        [self.navigationController pushViewController:controller animated:true];
    } doOnFailure:^(NSError *error) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Weather App" message:@"There was a problem getting this city forecast. Try again!" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:controller animated:true completion:nil];
    }];
}

#pragma mark - UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (!self.resetSearch) {
        return;
    }
    
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    _cities = self.cityListModel.cities;
    [self.tblCities reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _cities = [self.cityListModel filterWithCityName:searchText];
    [self.tblCities reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.resetSearch = false;
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.resetSearch = true;
    [searchBar resignFirstResponder];
}

@end
