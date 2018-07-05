//
//  WAWeatherViewControllerTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACityWeatherViewModel.h"
#import "WAWeatherViewController.h"
#import "WAForecastTableViewCell.h"
#import "WAForecast.h"
#import "WAForecastViewModel.h"
#import "MockNURLSession.h"
#import "Fixtures.h"

@interface WAWeatherViewControllerTests : XCTestCase

@property (nonatomic, strong) WAWeatherViewController *controller;

@end

@implementation WAWeatherViewControllerTests

- (void)setUp {
    [super setUp];
    
    NSMutableArray *forecasts = [NSMutableArray array];
    
    NSDictionary *dicto = @{@"date" : @"12 Jul 2018",
                            @"day" : @"Thu",
                            @"high" : @"89",
                            @"low" : @"71",
                            @"text" : @"Thunderstorms"};
    
    for (int i = 0; i < 20; i++) {
        
        WAForecast *model = [[WAForecast alloc] initWithDictionary:dicto];
        WAForecastViewModel *viewModel = [[WAForecastViewModel alloc] initWithForecast:model];
        [forecasts addObject:viewModel];
    }
    
    self.controller = [[WAWeatherViewController alloc] initWithForecasts:forecasts];
    [self.controller loadView];
}

//UITableView Tests

- (void)testWhenTableViewGetsPopulatedThenWeShouldSeeAStyledCell {
    //At the beginning, there should be 18 row
    XCTAssertEqual([self.controller.tableView numberOfRowsInSection:0], 20);
    [self.controller viewDidLoad];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    WAForecastTableViewCell *cell = [self.controller.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        //Per dummy data, the first cell should contain the following text
        XCTAssert([cell.lblDay.text isEqualToString:@"Thu"]);
        XCTAssert([cell.lblDate.text isEqualToString:@"12 Jul 2018"]);
        XCTAssert([cell.lblMax.text isEqualToString:@"89"]);
        XCTAssert([cell.lblMin.text isEqualToString:@"71"]);
        XCTAssert([cell.lblDescription.text isEqualToString:@"Thunderstorms"]);
    } else {
        XCTFail();
    }
}

@end
