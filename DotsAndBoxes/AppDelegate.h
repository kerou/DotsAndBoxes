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

@property (strong, nonatomic) SocketIOClient *socket;
@property (assign, nonatomic) NSUInteger userId;

+ (AppDelegate*)getInstance;
- (void)initializeSocket:(id)receiver;

@end

