//
//  DBGameTypeViewController.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/23/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DotsAndBoxes-Swift.h"

@interface DBGameTypeViewController : UIViewController
@property (weak, nonatomic) SocketIOClient *socket;
@property (assign, nonatomic) NSNumber *opponentId;

@end
