//
//  AppDelegate.m
//  TestNSDate
//
//  Created by Kosuke Matsuda on 2013/07/12.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self testDate];
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

- (void)testDate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDate *today = [NSDate date];
    NSLog(@"today >>>>>>>>>>>>>>> %@", today);
    NSLog(@"today formatter >>>>>>>>>>>>>>> %@", [formatter stringFromDate:today]);
    NSDateComponents *todayComps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    NSDate *midnight = [calendar dateFromComponents:todayComps];
    NSLog(@"today midnight >>>>>>>>>>>>>>> %@", midnight);

    NSDateComponents *comps = [NSDateComponents new];
    comps.year = todayComps.year;
    comps.month = todayComps.month;
    comps.day = todayComps.day - 1;
    comps.hour = 23;
    comps.minute = 59;
    NSDate *yesterday = [calendar dateFromComponents:comps];
    NSLog(@"yesterday >>>>>>>>>>>>>>> %@", yesterday);
    NSLog(@"yesterday formatter >>>>>>>>>>>>>>> %@", [formatter stringFromDate:yesterday]);

    NSDateComponents *c1 = [calendar components:NSDayCalendarUnit fromDate:yesterday toDate:today options:0];
    NSLog(@"%@ : %@ : c1.day >>>>>>>>>>>>>>>> %d", yesterday, today, c1.day);

    NSDateComponents *c2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:yesterday];
    NSDate *ymidnight = [calendar dateFromComponents:c2];

    NSDateComponents *c3 = [calendar components:NSDayCalendarUnit fromDate:ymidnight toDate:midnight options:0];
    NSLog(@"%@ : %@ : c3.day >>>>>>>>>>>>>>>> %d", ymidnight, midnight, c3.day);
}

@end
