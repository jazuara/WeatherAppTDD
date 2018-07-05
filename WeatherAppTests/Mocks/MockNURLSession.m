//
//  MockNURLSession.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "MockNURLSession.h"

//MockNSURLSessionDataTask

@interface MockNSURLSessionDataTask : NSURLSessionDataTask

typedef void (^CompletionHandler)(NSData* data, NSURLResponse* response, NSError *error);
@property (nonatomic, copy) CompletionHandler handler;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSError *responseError;

@end

@implementation MockNSURLSessionDataTask

- (void)resume {
    self.handler(self.responseData, nil, self.responseError);
}
@end

//MockNURLSession

@interface MockNURLSession ()

@property (nonatomic, strong) MockNSURLSessionDataTask *mockTask;

@end

@implementation MockNURLSession

- (NSURLSession *)initWithResponseString:(NSString *)responseString andError:(NSError *)error {
    
    self = [super init];
    if (self) {
        self.mockTask = [[MockNSURLSessionDataTask alloc] init];
        
        NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        self.mockTask.responseData = responseData;
        self.mockTask.responseError = error;
    }
    
    return self;
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    
    self.mockTask.handler = completionHandler;
    return self.mockTask;
}

@end


