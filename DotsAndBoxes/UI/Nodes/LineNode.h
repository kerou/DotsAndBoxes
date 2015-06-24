//
//  LineNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LineSprite.h"
#import "AppDelegate.h"

@class BoardNode;
@class DotNode;
@interface LineNode : SKNode

@property(weak, nonatomic) DotNode *dot;
@property(weak, nonatomic) BoardNode *board;
@property(strong, nonatomic) LineSprite *lineSprite;
@property(assign, nonatomic) BOOL isVertical;
@property(assign, nonatomic) BOOL connected;

- (id)initWithPosition:(CGPoint)position size:(CGFloat)lineSize andOrientation:(BOOL)isVertical;
@end
