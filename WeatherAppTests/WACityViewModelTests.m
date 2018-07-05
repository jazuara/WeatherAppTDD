//
//  WACityViewModelTests.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WACityViewModel.h"

@interface WACityViewModelTests : XCTestCase

@end

@implementation WACityViewModelTests

- (void)testWhenSendingValidDictionaryThenReturnValidObject {
    
    WACity *model = [[WACity alloc] initWithDictionary:@{@"city" : @"Royal Oak", @"state" : @"Michigan"}];
    
    WACityViewModel *viewModel = [[WACityViewModel alloc] initWithCity:model];
    
    XCTAssertNotNil(viewModel);
    XCTAssertNotNil(viewModel.city);
    XCTAssertNotNil(viewModel.weatherModel);
}

- (void)testWhenSendingNilThenReturnObjectWithDummyData {
    
    WACityViewModel *viewModel = [[WACityViewModel alloc] initWithCity:nil];
    
    XCTAssertNotNil(viewModel);
    XCTAssertNil(viewModel.city);
    XCTAssertNil(viewModel.weatherModel);
}

@end
