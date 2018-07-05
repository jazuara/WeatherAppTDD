//
//  WACityTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACity.h"

@interface WACityTests : XCTestCase

@end

@implementation WACityTests

- (void)testWhenSendingValidDictionaryThenReturnValidObject {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    
    XCTAssertNotNil(model);
    XCTAssert([model.city isEqualToString:@"Royal Oak"]);
    XCTAssert([model.state isEqualToString:@"Michigan"]);
}

- (void)testWhenSendingNilThenReturnObjectWithDummyData {
    
    WACity *model = [[WACity alloc] initWithDictionary:nil];
    
    XCTAssertNotNil(model);
    XCTAssert([model.city isEqualToString:@"No City Name Given"]);
    XCTAssert([model.state isEqualToString:@"No State Name Given"]);
}

@end
