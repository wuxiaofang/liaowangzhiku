//
//  AppDelegate.m
//  BaseProject
//
//  Created by yongche_w on 16/5/31.
//  Copyright © 2016年 wuxiaofang. All rights reserved.
//

#import "AppDelegate.h"
#import "WXFShareCenter.h"
#import "WXFWelcomeView.h"
#import "WXFBaseNavigationViewController.h"
#import "WXFShareCenter.h"
#import "WXFLoginViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong)WXFWelcomeView* welcomeView;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[WXFShareCenter instance] registerThirdSDK];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeViewController = [[WXFHomeViewController alloc] init];
    WXFBaseNavigationViewController* nav = [[WXFBaseNavigationViewController alloc] initWithRootViewController:self.homeViewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    self.welcomeView = [[WXFWelcomeView alloc] initWithFrame:self.window.bounds];
    
//    __weak typeof(self)weakSelf = self;
    
    self.welcomeView.dismissWelcomeViewBlock = ^(NSString* webviewUrl){
        
//        if(webviewUrl){
//            [weakSelf.homeViewController laodWebViewData:webviewUrl];
//        }else{
//            [weakSelf showLoginViewController];
//        }
    };
    
    [self.window addSubview:self.welcomeView];

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL openSources = NO;
    openSources = [[WXFShareCenter instance] application:application handleOpenURL:url];
    return openSources;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL openSources = NO;
    openSources = [[WXFShareCenter instance] application:application handleOpenURL:url];
    return openSources;
}

- (void)showLoginViewController
{
    WXFLoginViewController* login = [[WXFLoginViewController alloc] init];
    [self.window.rootViewController presentViewController:login animated:YES completion:^{
        
    }];
}

@end
