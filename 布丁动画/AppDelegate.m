//
//  AppDelegate.m
//  布丁动画
//
//  Created by Cheetah on 15/9/21.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "DIEBangumiViewController.h"
#import "DIELeftViewController.h"
@interface AppDelegate ()
{
    MMDrawerController *mmDrawerController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc]initWithFrame:frame];
    self.window.backgroundColor = [UIColor whiteColor];

    //番组内分页视图控制器,作为番组导航控制器的根视图控制器
    DIEBangumiViewController *bangumiViewController = [[DIEBangumiViewController alloc]init];
    //番组导航控制器,放第一个标签控制器的第一个位置
    UINavigationController *bangumiNavigationController = [[UINavigationController alloc]initWithRootViewController:bangumiViewController];
    bangumiNavigationController.tabBarItem.image = [[UIImage imageNamed:@"global_footer_btn_new_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bangumiNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"global_footer_btn_new_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //标签控制器,装<番组>,<时间线>,<异次元>
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    mainTabBarController.viewControllers = @[bangumiNavigationController];
    
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    
    //抽屉左侧边栏控制器
    DIELeftViewController *leftViewController = [DIELeftViewController new];
    
    //抽屉控制器,当作App的Window的根视图控制器
    mmDrawerController = [[MMDrawerController alloc]initWithCenterViewController:mainTabBarController leftDrawerViewController:leftViewController];
    mmDrawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningNavigationBar|MMOpenDrawerGestureModePanningCenterView;
    mmDrawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll ^ MMCloseDrawerGestureModeBezelPanningCenterView;
    
    self.window.rootViewController = mmDrawerController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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

@end
