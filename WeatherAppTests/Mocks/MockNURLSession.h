//
//  MockNURLSession.h
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockNURLSession : NSURLSession

- (NSURLSession *)initWithResponseString:(NSString *)responseString andError:(NSError *)error;
    
@end
