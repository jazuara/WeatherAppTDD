//
//  WACitiesViewController.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WACityListViewModel.h"
#import "WACityViewModel.h"
#import "WeatherEngine.h"

@interface WACitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, readonly) WACityListViewModel *cityListModel;

//An Array of city models
@property (nonatomic, readonly) NSArray *cities;

@property (nonatomic, weak) IBOutlet UITableView *tblCities;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

- (instancetype)initWithModel:(WACityListViewModel *)model;

@end
