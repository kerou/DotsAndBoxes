//
//  AppDelegate.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotsAndBoxes-Swift.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIAlertView *gameRequestAlertView;
@property (assign, nonatomic) BOOL isPlaying;
@property (assign, nonatomic) NSUInteger boardSize;
@property (strong, nonatomic) SocketIOClient *socket;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *opponentId;
+ (AppDelegate*)getInstance;
- (void)initializeSocket:(id)receiver;
- (void)disconnect;
- (void)presentGameViewControllerWithSize:(NSUInteger)boardSize andTurn:(BOOL)isMe;
@end

