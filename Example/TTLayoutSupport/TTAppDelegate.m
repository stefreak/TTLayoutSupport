//
//  TTAppDelegate.m
//  TTLayoutSupport
//
//  Created by CocoaPods on 11/25/2014.
//  Copyright (c) 2014 Steffen Neubauer. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTDemoParentViewController.h"
#import "TTDemoChildViewController.h"
#import "TTDemoScrollViewController.h"
#import "TTDemoTableViewController.h"
#import "TTDemoCollectionViewController.h"

@interface TTAppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UITabBarController *)tabBarController
{
    if (_tabBarController) {
        return _tabBarController;
    }

    _tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *uiviewcontrollerDemo = [[UINavigationController alloc] init];
    uiviewcontrollerDemo.tabBarItem.title = @"No ScrollView";
    uiviewcontrollerDemo.viewControllers = @[[[TTDemoParentViewController alloc] initWithChildViewController:
                                              [[TTDemoChildViewController alloc] init]]];

    UINavigationController *storyboardcontrollerDemo = [[UINavigationController alloc] init];
    storyboardcontrollerDemo.tabBarItem.title = @"Storyboard";
    UIViewController *storyboardViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Storyboard Controller"];
    storyboardcontrollerDemo.viewControllers = @[[[TTDemoParentViewController alloc] initWithChildViewController:storyboardViewController]];
    
    UINavigationController *uiviewcontrollerScrollviewDemo = [[UINavigationController alloc] init];
    uiviewcontrollerScrollviewDemo.viewControllers = @[[[TTDemoParentViewController alloc] initWithChildViewController:
                                                        [[TTDemoScrollViewController alloc] init]]];
    uiviewcontrollerScrollviewDemo.tabBarItem.title = @"ScrollView";
    
    UINavigationController *uitableviewcontrollerDemo = [[UINavigationController alloc] init];
    uitableviewcontrollerDemo.viewControllers = @[[[TTDemoParentViewController alloc] initWithChildViewController:
                                                   [[TTDemoTableViewController alloc] init]]];
    uitableviewcontrollerDemo.tabBarItem.title = @"TableView";

    UINavigationController *uicollectionviewcontrollerDemo = [[UINavigationController alloc] init];
    uicollectionviewcontrollerDemo.viewControllers = @[[[TTDemoParentViewController alloc] initWithChildViewController:
                                                        [[TTDemoCollectionViewController alloc] init]]];
    uicollectionviewcontrollerDemo.tabBarItem.title = @"CollectionView";
    
    _tabBarController.viewControllers = @[uiviewcontrollerDemo, storyboardcontrollerDemo, uiviewcontrollerScrollviewDemo, uitableviewcontrollerDemo, uicollectionviewcontrollerDemo];
    
    return _tabBarController;
}

@end
