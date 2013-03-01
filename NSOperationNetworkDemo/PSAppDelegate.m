//
//  PSAppDelegate.m
//  NSOperationNetworkDemo
//
//  Created by Andrew Carter on 2/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import "PSAppDelegate.h"

#import "PSRootViewController.h"

@implementation PSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];

    PSRootViewController *rootViewController = [PSRootViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [[self window] setRootViewController:navigationController];
    
    [[self window] makeKeyAndVisible];
    return YES;
}

@end
