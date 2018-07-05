//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Javier Azuara on 2018/06/30.
//  Copyright © 2018年 Javier Azuara. All rights reserved.
//

#import "AppDelegate.h"
#import "WACitiesViewController.h"
#import "WACityListViewModel.h"
#import "WeatherEngine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    WeatherEngine *engine = [[WeatherEngine alloc] init];
    
    WACityListViewModel *model = [[WACityListViewModel alloc] initWithCities:[engine getAllCities]];
    
    WACitiesViewController *controller = [[WACitiesViewController alloc] initWithModel:model];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
