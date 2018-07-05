//
//  WAForecastTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WAForecast.h"

@interface WAForecastTests : XCTestCase

@end

@implementation WAForecastTests

- (void)testWhenSendingValidDictionaryThenReturnValidObject {
    
    NSDictionary *data = @{@"date" : @"12 Jul 2018",
                           @"day" : @"Thu",
                           @"high" : @"89",
                           @"low" : @"71",
                           @"text" : @"Thunderstorms"};
    WAForecast *model = [[WAForecast alloc] initWithDictionary:data];
    
    XCTAssertNotNil(model);
    XCTAssert([model.date isEqualToString:@"12 Jul 2018"]);
    XCTAssert([model.day isEqualToString:@"Thu"]);
    XCTAssert([model.max isEqualToString:@"89"]);
    XCTAssert([model.min isEqualToString:@"71"]);
}

- (void)testWhenSendingNilThenReturnObjectWithDummyData {
    
    WAForecast *model = [[WAForecast alloc] initWithDictionary:nil];
    
    XCTAssertNotNil(model);
    XCTAssert([model.date isEqualToString:@"Not Especified"]);
    XCTAssert([model.day isEqualToString:@"Not Especified"]);
    XCTAssert([model.max isEqualToString:@"Not Especified"]);
    XCTAssert([model.min isEqualToString:@"Not Especified"]);
}

@end
