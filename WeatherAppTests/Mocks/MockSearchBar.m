//
//  MockSearchBar.m
//  WeatherAppTests
//
//  Created by Javier Azuara on 2018/07/02.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "MockSearchBar.h"

@implementation MockSearchBar

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [self.delegate searchBarTextDidEndEditing:self];
    return YES;
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    [self.delegate searchBarTextDidBeginEditing:self];
    return YES;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self.delegate searchBar:self textDidChange:text];
}

@end
