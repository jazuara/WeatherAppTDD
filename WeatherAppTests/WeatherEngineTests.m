//
//  WeatherEngineTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherEngine.h"
#import "MockWeatherEngine.h"

@interface WeatherEngineTests : XCTestCase

@end

@implementation WeatherEngineTests

- (void)testGetAllCitiesSuccesfully {
    
    WeatherEngine *engine = [[WeatherEngine alloc] init];
    XCTAssertEqual([[engine getAllCities] count], 5977);
}

- (void)testWhenSendingWrongPathToFetchAllCitiesThenWeGetAnEmptyCityList {
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    engine.filePath = @"MXCities";
    XCTAssertEqual([[engine getAllCities] count], 0);
}

- (void)testWhenSendingACorruptedFileToFetchAllCitiesThenReturnAnEmptyList {
    MockWeatherEngine *engine = [[MockWeatherEngine alloc] init];
    engine.filePath = @"CANCities";
    XCTAssertEqual([[engine getAllCities] count], 0);
}

@end
