//
//  EPCTAppDelegate.m
//  EPCheckerTest
//
//  Created by Puttin Wong on 12/02/13.
//  Copyright (c) 2013 Extensivepro. All rights reserved.
//

#import "EPCTAppDelegate.h"
#import "EPCTMainViewController.h"

@implementation EPCTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    EPCTMainViewController *mainViewController = [EPCTMainViewController new];
    self.window.rootViewController = mainViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
