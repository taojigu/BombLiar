//
//  AppDelegate.m
//  BombLiar
//
//  Created by VooleDev6 on 14-3-31.
//  Copyright (c) 2014年 VooleDev6. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "ConstConfig.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    Reachability*curReach=[Reachability reachabilityForInternetConnection];
    
    if([curReach currentReachabilityStatus]!=NotReachable){
        NSLog(@"Should not run under 3G");
       // return NO;
    }
    
    [self checkDefaultSettings];
    
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


#pragma mark -- private messages

-(void)checkDefaultSettings{
    NSInteger density=[[NSUserDefaults standardUserDefaults] integerForKey:DefaultSettingDensityKey];
    if (0==density) {
        density=100;
        [[NSUserDefaults standardUserDefaults]setInteger:density forKey:DefaultSettingDensityKey];
    }
}
@end
