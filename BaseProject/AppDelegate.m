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
#import "WXFReportViewController.h"

static NSString *appKey = @"b5df8393a621ba8ef1294ab8";
static NSString *channel = @"1";

#ifdef DEBUG
static BOOL isProduction = FALSE;
#else
static BOOL isProduction = TRUE;
#endif


@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong)WXFWelcomeView* welcomeView;

@property (nonatomic, assign)BOOL appisBackGround;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[WXFShareCenter instance] registerThirdSDK];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
#ifdef DEBUG
//    static BOOL isProduction = FALSE;
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:channel
                 apsForProduction:FALSE
            advertisingIdentifier:nil];
#else
//    static BOOL isProduction = TRUE;
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:channel
                 apsForProduction:TRUE
            advertisingIdentifier:nil];
#endif
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x1dbbe6),NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGB(0xb8b8b8),NSFontAttributeName:[UIFont systemFontOfSize:11]}            forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGB(0x1dbbe6),NSFontAttributeName:[UIFont systemFontOfSize:11]}            forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0x1dbbe6)] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setBarTintColor:UIColorFromRGB(0xf7f7f7)];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.tabbarController =  [storyBoard instantiateViewControllerWithIdentifier:@"WXFTabbarViewController"];
    self.tabbarController.delegate = self;
    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
    
    UITabBar *tabBar = self.tabbarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    // 对item设置相应地图片
    item0.imageInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
    item0.selectedImage = [[UIImage imageNamed:@"foot_1act"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"foot_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.imageInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
    item1.selectedImage = [[UIImage imageNamed:@"foot_2act"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image = [[UIImage imageNamed:@"foot_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.imageInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
    item2.selectedImage = [[UIImage imageNamed:@"foot_3act"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.image = [[UIImage imageNamed:@"foot_3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item3.imageInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
    item3.selectedImage = [[UIImage imageNamed:@"foot_4act"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.image = [[UIImage imageNamed:@"foot_4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return YES;
}


- (void)initThirdParty
{

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    self.appisBackGround = YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.appisBackGround = NO;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    [self handlePushNotification:userInfo application:application];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSLog(@"%@",userInfo);
    [self handlePushNotification:userInfo application:application];
//    {
//        "_j_msgid" = 3790880132;
//        aps =     {
//            alert = jqkjskwjkdwer;
//            badge = 1;
//            sound = default;
//        };
//    }
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)handlePushNotification:(NSDictionary*)userInfo application:(UIApplication *)application
{
    NSString* msg_id = [userInfo stringSafeForKey:@"msg_id"];
    NSDictionary*aps = [userInfo dictionarySafeForKey:@"aps"];
    NSString* alertString = [aps stringSafeForKey:@"alert"];
    
    if(msg_id.length > 0){
        NSMutableDictionary* paramater = [NSMutableDictionary dictionary];
        [paramater setValue:msg_id forKey:@"msg_id"];
        
        
        [[WXFHttpClient shareInstance] getData:@"/app/comm/center/message/push.jspx" parameters:paramater callBack:^(WXFParser *parser) {
            
            NSString* url = [parser.responseDictionary stringSafeForKey:@"url"];
            NSLog(@"msg_id = %@  返回值=%@",msg_id,parser.responseDictionary);
            if(url.length > 0){
                
                if (application.applicationState == UIApplicationStateActive) {
                    
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:@"查看", nil];
                    [alert show];
                    RACSignal* signal = [alert rac_buttonClickedSignal];
                    [signal subscribeNext:^(id x) {
                        if ([x intValue] == 1) {
                            WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
                            vc.webviewUrl = url;
                            [self.homeViewController.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                    
                    //激活
                } else if (application.applicationState == UIApplicationStateInactive) {
                    WXFBaseWebViewController* vc = [[WXFBaseWebViewController alloc] init];
                    vc.webviewUrl = url;
                    [self.homeViewController.navigationController pushViewController:vc animated:YES];
                }
                
                
            }
            
        }];
    }
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{

    [[WXFShareCenter instance] application:application handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
     [[WXFShareCenter instance] application:application handleOpenURL:url];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}


@end
