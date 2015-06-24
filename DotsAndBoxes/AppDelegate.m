//
//  AppDelegate.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"
#import "DBGameContainerViewController.h"

@interface AppDelegate () <UIAlertViewDelegate>

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
    SocketIOClient* socket = [[SocketIOClient alloc] initWithSocketURL:@"192.168.25.85:3001" options:nil];
    
    [socket on:@"connect" callback:^(NSArray* data, void (^ack)(NSArray*)) {
        [receiver setValue:socket forKey:@"socket"];
    }];
    
    [socket on:@"didLogin" callback:^(NSArray * data, void (^ack)(NSArray*)) {
        NSDictionary *didLoginDict = data[0];
        self.userId = didLoginDict[@"userId"];
        [socket emit:@"getAvailablePlayers" withItems:@[self.userId]];
    }];
    
    [socket on:@"availablePlayers"callback:^(NSArray * data, void (^ ack)(NSArray *)) {
        NSDictionary *availablePlayers = data[0];
        NSArray *players = availablePlayers[@"availablePlayers"];
        [receiver setValue:players forKey:@"players"];
    }];
    
    [socket on:@"playRequest" callback:^(NSArray * data, void (^ ack)(NSArray*)) {
        NSDictionary *dataDict = data[0];
        self.opponentId = dataDict[@"requesterId"];
        if(!self.gameRequestAlertView.visible) {
            if(!self.isPlaying) {
                self.boardSize = [dataDict[@"gameType"] unsignedIntegerValue];
                NSString *message = [NSString stringWithFormat:@"Would you like to play a game?"];
                self.gameRequestAlertView = [[UIAlertView alloc] initWithTitle:@"Play Request" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"OK", nil];
                [self.gameRequestAlertView show];
            } else {
                [socket emit:@"denyGame" withItems:@[ @{@"opponentId" : self.opponentId}]];
            }
        }
    }];
    
    [socket on:@"gameDenied" callback:^(NSArray * data, void (^ ack)(NSArray*)) {
        NSLog(@"Game Denied!");
    }];
    
    [socket on:@"gameAccepted" callback:^(NSArray * data, void (^ ack)(NSArray *)) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DBGameContainerViewController *gameContainerViewController = [storyboard instantiateViewControllerWithIdentifier:@"gameContainerViewController"];
        gameContainerViewController.boardSize = self.boardSize;
        gameContainerViewController.isMe = NO;
        //    [self.window.rootViewController addChildViewController:gameContainerViewController];
        [self.window.rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window.rootViewController presentViewController:gameContainerViewController animated:YES completion:^{
                
            }];
        }];
    }];
    
    [socket on:@"lineAdded" callback:^(NSArray * data, void (^ ack)(NSArray *)) {
        NSLog(@"Line Added");
        NSDictionary *dataDict = data[0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bg.paperjam.dotsandboxes.playercreatedline" object:dataDict];
    }];
    
//    [socket on:@"playerJoined" callback:^(NSArray * data, void (^ ack)(NSArray *)) {
//        [self.socket emit:@"getAvailablePlayers" withItems:@[[AppDelegate getInstance].userId]];
//    }];

    [socket connect];
    self.socket = socket;
}

- (void)disconnect
{
    [self.socket emit:@"disconnectUser" withItems:@[@{ @"userId" : self.userId}]];
}

- (void)denyGame
{
    [self.socket emit:@"denyGame" withItems:@[@{ @"opponentId" : self.opponentId}]];
}

#pragma mark - Alert View Delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"AlertView clicked button at index");
    if(buttonIndex == 1) {
        self.isPlaying = YES;
        [self.socket emit:@"acceptGame" withItems:@[@{@"opponentId" : self.opponentId}]];
        [self presentGameViewControllerWithSize:self.boardSize andTurn:YES];
    } else if (buttonIndex == 0) {
        NSLog(@"Cancel");
        [self denyGame];
    }
}

- (void)presentGameViewControllerWithSize:(NSUInteger)boardSize andTurn:(BOOL)isMe
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DBGameContainerViewController *gameContainerViewController = [storyboard instantiateViewControllerWithIdentifier:@"gameContainerViewController"];
    gameContainerViewController.boardSize = boardSize;
    gameContainerViewController.isMe = isMe;

    NSLog(@"%@", self.window.rootViewController);
    
    if(self.window.rootViewController.presentedViewController) {
        [self.window.rootViewController dismissViewControllerAnimated:NO completion:^{
            [self.window.rootViewController presentViewController:gameContainerViewController animated:YES completion:^{
                
            }];
        }];
    } else {
        [self.window.rootViewController presentViewController:gameContainerViewController animated:YES completion:^{
            
        }];
    }

}

- (BOOL)isModal:(UIViewController *)vc
{
    return vc.presentingViewController.presentedViewController == vc
    || (vc.navigationController != nil && vc.navigationController.presentingViewController.presentedViewController == vc.navigationController)
    || [vc.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}

@end
