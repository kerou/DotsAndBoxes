//
//  BoardNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LineNode.h"
#import "DotNode.h"
#import "BoxNode.h"
#import "AppDelegate.h"

@interface BoardNode : SKNode

@property(assign, nonatomic) BOOL isMe;
@property(assign, nonatomic) CGSize boardSize;
@property(assign, nonatomic) NSUInteger allyBoxCount;
@property(assign, nonatomic) NSUInteger opponentBoxCount;

- (id)initWithDimension:(NSUInteger)dimension andBoardSize:(CGSize)boardSize;
- (void)lineNode:(LineNode *)line didChangeState:(BOOL)isConnected;
@end