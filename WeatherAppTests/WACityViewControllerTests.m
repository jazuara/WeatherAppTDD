//
//  WACityViewControllerTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACitiesViewController.h"
#import "WAWeatherViewController.h"
#import "MockWeatherEngine.h"
#import "MockSearchBar.h"
#import "MockNURLSession.h"
#import "Fixtures.h"

@interface WACityViewControllerTests : XCTestCase

@property (nonatomic, strong) WACitiesViewController *controller;
@property (nonatomic, strong) MockSearchBar *searchBar;

@end

@implementation WACityViewControllerTests

- (void)setUp {
    [super setUp];
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    WACityListViewModel *listModel = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    self.controller = [[WACitiesViewController alloc] initWithModel:listModel];
    [self.controller loadView];
    
    //Replace search bar with mock
    self.searchBar = [[MockSearchBar alloc] init];
    self.searchBar.delegate = self.controller;
    self.controller.searchBar = self.searchBar;
}

- (void)testWhenSendingValidModelThenReturnValidObject {
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    WACityListViewModel *listModel = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    WACitiesViewController *controller = [[WACitiesViewController alloc] initWithModel:listModel];
    
    [controller loadView];

    //Demo data has 18 cities
    XCTAssertEqual(controller.cities.count, 18);
    XCTAssertNotNil(controller.cityListModel);
    
    XCTAssertNotNil(controller.searchBar);
    XCTAssertNotNil(controller.tblCities);
    
    XCTAssertNotNil(controller.searchBar.delegate);
    XCTAssertNotNil(controller.tblCities.dataSource);
    XCTAssertNotNil(controller.tblCities.delegate);
}

//UITableView Tests

- (void)testWhenSearchingACityThenTableViewReflectsTheChange {
    
    //At the beginning, there should be 18 row
    XCTAssertEqual([self.controller.tblCities numberOfRowsInSection:0], 18);
    
    //When
    self.controller.searchBar.text = @"Ada";
    
    //Then
    XCTAssertEqual([self.controller.tblCities numberOfRowsInSection:0], 2);
}

- (void)testWhenTableViewGetsPopulatedThenWeShouldSeeAStyledCell {
    //At the beginning, there should be 18 row
    XCTAssertEqual([self.controller.tblCities numberOfRowsInSection:0], 18);
    [self.controller viewDidLoad];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.controller.tblCities cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        //Cell should contain the city as main text and the state as detail text.
        //Per dummy data, the first cell should contain the following text
        XCTAssert([cell.textLabel.text isEqualToString:@"Abbeville"]);
        XCTAssert([cell.detailTextLabel.text isEqualToString:@"Louisiana"]);
    } else {
        XCTFail();
    }
}

//Search Bar tests

- (void)testWhenActivatingSearchBarThenCancelButtonShowsUp {
    
    [self.controller.searchBar becomeFirstResponder];
    XCTAssertEqual(self.controller.searchBar.showsCancelButton, true);
}

- (void)testWhenSearchBarEditionEndsThenSearchBarResets {
    
    self.controller.searchBar.text = @"City Example";
    
    [self.controller.searchBar resignFirstResponder];
    
    XCTAssert([self.controller.searchBar.text isEqualToString:@""]);
    XCTAssertEqual(self.controller.searchBar.showsCancelButton, NO);
}

- (void)testWhenSearchIsActivelyEditedThenCitiesAreFiltered {
    
    self.controller.searchBar.text = @"Ada";
    //2 cities matched \"Ada\"
    XCTAssertEqual(self.controller.cities.count, 2);
}

- (void)testWhenSearchBarEditionEndsThenCityListGetOriginalContent {
    
    //Assuming there is a search going on
    self.controller.searchBar.text = @"Ada";
    XCTAssertEqual(self.controller.cities.count, 2);
    
    //When
    [self.controller.searchBar resignFirstResponder];
    
    //Then
    XCTAssertEqual(self.controller.cities.count, 18);
}

- (void)testWhenSearchBarCancelButtonIsClickedThenSearchBarResets {
    //This is a duplicate of testWhenSearchBarEditionEndsThenSearchBarResets,
    //but testing behavior
    
    self.controller.searchBar.text = @"City Example";
    
    [self.controller searchBarCancelButtonClicked:self.controller.searchBar];
    
    XCTAssert([self.controller.searchBar.text isEqualToString:@""]);
    XCTAssertEqual(self.controller.searchBar.showsCancelButton, NO);
}

- (void)testWhenSearchBarSearchButtonIsClickedThenSearchIsKept {
    //Assuming there is a search going on
    self.controller.searchBar.text = @"Ada";
    XCTAssertEqual(self.controller.cities.count, 2);
    
    //When
    [self.controller searchBarSearchButtonClicked:self.controller.searchBar];
    
    //Then
    XCTAssertEqual(self.controller.cities.count, 2);
}

//Selection Tests

- (void)testWhenSelectingACityThenWeGetErrorDueFetchFailed {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    WACityViewModel *viewModel = [[WACityViewModel alloc] initWithCity:model];
    
    //Mock
    NSError *error = [[NSError alloc] initWithDomain:@"com.mocknetwork.fail" code:100 userInfo:nil];
    MockNURLSession *session = [[MockNURLSession alloc] initWithResponseString:nil andError:error];
    viewModel.weatherModel.engine.URLSession = session;
    
    //Initializing controller
    WACityListViewModel *listModel = [[WACityListViewModel alloc] initWithCities:@[viewModel]];
    
    WACitiesViewController *listController = [[WACitiesViewController alloc] initWithModel:listModel];
    [UIApplication sharedApplication].keyWindow.rootViewController = listController;
    
    //When
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [listController tableView:self.controller.tblCities didSelectRowAtIndexPath:path];
    
    //Then
    if ([listController.presentedViewController isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)listController.presentedViewController;
        XCTAssert([alertController.message isEqualToString:@"There was a problem getting this city forecast. Try again!"]);
    }else {
        XCTFail();
    }
}

- (void)testWhenSelectingACityThenWeGetForecast {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    WACityViewModel *viewModel = [[WACityViewModel alloc] initWithCity:model];
    
    //Mock
    MockNURLSession *session = [[MockNURLSession alloc] initWithResponseString:FORECAST_RESPONSE andError:nil];
    viewModel.weatherModel.engine.URLSession = session;
    
    //Initializing controller
    WACityListViewModel *listModel = [[WACityListViewModel alloc] initWithCities:@[viewModel]];
    
    WACitiesViewController *listController = [[WACitiesViewController alloc] initWithModel:listModel];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:listController];
    
    //When
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [listController tableView:listController.tblCities didSelectRowAtIndexPath:path];
    
    //Then
    XCTestExpectation *expectation = [self expectationWithDescription:@"testWhenSelectingACityThenWeGetForecast"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([listController.navigationController.topViewController isKindOfClass:[WAWeatherViewController class]]) {
            XCTAssert(YES);
        }else {
            XCTFail();
        }
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

@end
