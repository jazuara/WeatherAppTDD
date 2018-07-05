//
//  WACityListViewModelTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACityListViewModel.h"
#import "WACityViewModel.h"
#import "MockWeatherEngine.h"

@interface WACityListViewModelTests : XCTestCase

@end

@implementation WACityListViewModelTests

- (void)testWhenSendingValidDictionaryThenReturnValidObject {
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    XCTAssertNotNil(model);
    XCTAssertEqual(model.cities.count, 18);
}

- (void)testWhenSendingNilThenReturnObjectWithDummyData {
    
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:nil];
    
    XCTAssertNotNil(model);
    XCTAssertEqual(model.cities.count, 0);
}

//Filtering tests

- (void)testWhenSendingValidStringThenWeGetCitiesFiltered {
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    //The example data has 2 cities named "Abington"
    XCTAssertEqual([[model filterWithCityName:@"Abington"] count], 2);
}

- (void)testWhenSendingEmptyStringThenWeGetCitiesNotFiltered {
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    XCTAssertEqual([[model filterWithCityName:@""] count], 0);
}

- (void)testWhenSendingNilThenWeGetCititesNotFiltered {
    
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    XCTAssertEqual([[model filterWithCityName:nil] count], 0);
    
}

@end
