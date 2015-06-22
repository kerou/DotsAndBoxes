//
//  AppDelegate.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate*)getInstance
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

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

- (void)initializeSocket:(id)receiver
{
    SocketIOClient* socket = [[SocketIOClient alloc] initWithSocketURL:@"localhost:3001" options:nil];
    
    [socket on:@"connect" callback:^(NSArray* data, void (^ack)(NSArray*)) {
        self.socket = socket;
        [receiver setValue:socket forKey:@"socket"];
    }];
    
    [socket on:@"didLogin" callback:^(NSArray * data, void (^ack)(NSArray*)) {
        NSDictionary *didLoginDict = data[0];
        self.userId = [didLoginDict[@"userId"] unsignedIntegerValue];
        NSArray *players = didLoginDict[@"connectedUsers"];
        [receiver setValue:players forKey:@"players"];
    }];
    
//    [socket on:@"disconnect" callback:^(NSArray * data, void (^ack)(NSArray*)) {
//        
//    }];
    

    [socket connect];
}

@end
