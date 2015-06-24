//
//  LineNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "LineNode.h"
#import "DotNode.h"
#import "BoardNode.h"

@implementation LineNode

- (id)initWithPosition:(CGPoint)position size:(CGFloat)lineSize andOrientation:(BOOL)isVertical;
{
    if(self = [super init]) {
        self.userInteractionEnabled = YES;
        self.isVertical = isVertical;
        self.lineSprite = [[LineSprite alloc] initWithSize:lineSize];
        if (self.isVertical) {
            self.lineSprite.position = CGPointMake(position.x, position.y + 2*lineSize);
            self.lineSprite.zRotation = M_PI_2;
        } else {
            self.lineSprite.position = CGPointMake(position.x + 2*lineSize, position.y);
        }
        [self addChild:self.lineSprite];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchLocation];
    if ([touchedNode.parent isMemberOfClass:[LineNode class]]) {
        LineNode *lineNode = (LineNode *)touchedNode.parent;
        if(self.board.isMe) {
            if(!lineNode.connected) {
                if(touchedNode.alpha == 0) {
                    lineNode.lineSprite.isAlly = YES;
                    lineNode.connected = YES;
                    DotNode *dot = lineNode.dot;
                    NSNumber *dotRow = [NSNumber numberWithInteger:dot.row];
                    NSNumber *dotColumn = [NSNumber numberWithInteger:dot.column];
                    NSNumber *isVertical = lineNode.isVertical ? @1 : @0;
                    NSLog(@"OpponentId: %@", [AppDelegate getInstance].opponentId);
                    [[AppDelegate getInstance].socket emit:@"addLine" withItems:@[@{@"opponentId" : [AppDelegate getInstance].opponentId ,@"row" : dotRow, @"column" : dotColumn, @"isVertical" : isVertical}]];
                }
            }
        }
    }
}

- (void)setConnected:(BOOL)connected
{
    _connected = connected;
    if(connected) {
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.1];
        [self.lineSprite runAction:fadeIn];
    }
    [self.board lineNode:self didChangeState:YES];
}

@end
