//
//  WACityWeatherViewModelTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACityWeatherViewModel.h"
#import "MockNURLSession.h"
#import "Fixtures.h"

@interface WACityWeatherViewModelTests : XCTestCase

@end

@implementation WACityWeatherViewModelTests

- (void)testWhenSendingValidDictionaryThenReturnValidObject {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    WACityWeatherViewModel *viewModel = [[WACityWeatherViewModel alloc] initWithCity:model];

    XCTAssertNotNil(viewModel);
    XCTAssertNotNil(viewModel.city);
    XCTAssertNotNil(viewModel.engine);
}

- (void)testWhenSendingNilThenReturnObjectWithDummyData {
    
    WACityWeatherViewModel *viewModel = [[WACityWeatherViewModel alloc] initWithCity:nil];
    
    XCTAssertNotNil(viewModel);
    XCTAssertNil(viewModel.city);
    XCTAssertNotNil(viewModel.engine);
}

- (void)testFetchingCityForecastIsSuccessfull {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    WACityWeatherViewModel *viewModel = [[WACityWeatherViewModel alloc] initWithCity:model];
    
    //Mock
    MockNURLSession *session = [[MockNURLSession alloc] initWithResponseString:FORECAST_RESPONSE andError:nil];
    viewModel.engine.URLSession = session;
    
    [viewModel getForecastDoOnSuccess:^(NSString *cityQuery, NSArray *forecasts) {
        XCTAssert([cityQuery isEqualToString:@"Royal Oak, Michigan"]);
        XCTAssertEqual([forecasts count], 10);
    } doOnFailure:^(NSError *error) {
        XCTFail();
    }];
}

- (void)testFetchingCityForecastFails {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    WACityWeatherViewModel *viewModel = [[WACityWeatherViewModel alloc] initWithCity:model];
    
    NSError *error = [[NSError alloc] initWithDomain:@"com.mocknetwork.fail" code:100 userInfo:nil];
    MockNURLSession *session = [[MockNURLSession alloc] initWithResponseString:nil andError:error];
    viewModel.engine.URLSession = session;
    
    [viewModel getForecastDoOnSuccess:^(NSString *cityQuery, NSArray *forecasts) {
        XCTFail();
    } doOnFailure:^(NSError *error) {
        XCTAssertNotNil(error);
    }];
}

@end
