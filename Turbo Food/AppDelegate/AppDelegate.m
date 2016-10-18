//
//  AppDelegate.m
//  Turbo Food
//
//  Created by Ravi on 2/23/16.
//  Copyright (c) 2016 Ravi. All rights reserved.
//

#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ViewController2.h"




@interface AppDelegate ()
{
    MFSideMenuContainerViewController *container;
}
@end

@implementation AppDelegate
@synthesize window,navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIImage *image1 = [UIImage imageNamed:@"actionbar_bg1.png"];
    [[UINavigationBar appearance] setBackgroundImage:image1 forBarMetrics:UIBarMetricsDefault];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
     //I have instantiated using storyboard id.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
   container = (MFSideMenuContainerViewController *)self.window.rootViewController;
   
    
     UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
     UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];
    
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //ios8 ++
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        }
    }
    else
    {
        // ios7
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotificationTypes:)])
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        }
    }
   
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
    
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/// PUSH NOTIFICATION
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // available in iOS8
{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *StrTurboToken = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    StrTurboToken = [StrTurboToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    StrTurboToken = [StrTurboToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    StrTurboToken = [StrTurboToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"%@",StrTurboToken);
    
    [[NSUserDefaults standardUserDefaults] setValue:StrTurboToken forKey:@"Device_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
   // [self checkInternetAvaibility];
    
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    // here you need to check in which view controller is right now on screen;
    //1. if it is same in which you are then no problem just referesh controller;
    //otherwise push to your view controller like following"
    //    NotificationVC *aNotificationVC = [[NotificationVC alloc] initWithNibName:@"NotificationVC" bundle:nil];
    //    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:aNotificationVC];
    //    //UINavigationController *navigation=[[UINavigationController alloc]initWithRootViewController:aNotificationVC];
    //    self.window.rootViewController = nav;
    //    [self.window makeKeyAndVisible];
    
    //[nav pushviewcontroller:aNotificationVC animated:YES];
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        NSString *cancelTitle = @"Close";
        NSString *showTitle = @"Montrer";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Turbo Food"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:showTitle, nil];
        [alertView show];
       
    } else {
        //Do stuff that you would do if the application was not active
    }
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error:%@",error);
}




@end
