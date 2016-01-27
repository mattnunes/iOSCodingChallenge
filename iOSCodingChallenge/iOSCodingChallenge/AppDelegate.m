//
//  AppDelegate.m
//  iOSCodingChallenge
//
//  Created by Administrator on 5/6/15.
//  Copyright (c) 2015 Touch of Modern. All rights reserved.
//

#import "AppDelegate.h"
#import "DataService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Set up an NSURLCache so that the images won't be downloaded all the time
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache setMemoryCapacity:100 /*MB*/ * 1024 * 1024];
    [cache setDiskCapacity:100 /*MB*/ * 1024 * 1024];
    
    return YES;
}

@end
