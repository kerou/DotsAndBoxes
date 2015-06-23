//
//  DBGameContainerViewController.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/23/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface DBGameContainerViewController : UIViewController
@property (assign,nonatomic) BOOL isMe;
@property (assign, nonatomic) NSUInteger boardSize;
@property (strong, nonatomic) GameViewController *gameViewController;
@end
