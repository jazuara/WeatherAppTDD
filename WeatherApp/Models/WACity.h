//
//  WACity.h
//  WeatherApp
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WACity : NSObject

@property (nonatomic, readonly) NSString *city;
@property (nonatomic, readonly) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
