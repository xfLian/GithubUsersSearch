//
//  AppDelegate.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AppDelegate.h"
#import "UsersSearchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    sleep(2);
    
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.tintColor       = [UIColor colorWithRed:0
                                                  green:0
                                                   blue:0
                                                  alpha:1];
    
    UsersSearchViewController *rootViewController = [[UsersSearchViewController alloc] init];
    self.window.rootViewController                = rootViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

@end
