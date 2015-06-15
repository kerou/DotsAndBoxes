//
//  LineNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "LineNode.h"
#import "BoardNode.h"
@implementation LineNode

- (id)initWithPosition:(CGPoint)position size:(CGFloat)lineSize andOrientation:(BOOL)isVertical;
{
    if(self = [super init]) {
        self.userInteractionEnabled = YES;
        self.isVertical = isVertical;
        self.lineSprite = [[LineSprite alloc] initWithSize:lineSize];
        if (self.isVertical) {
            self.position = CGPointMake(position.x, position.y + 2*lineSize);
            self.lineSprite.zRotation = M_PI_2;
        } else {
            self.position = CGPointMake(position.x + 2*lineSize, position.y);
        }
        [self addChild:self.lineSprite];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.board.isMe) {
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *touchedNode = [self nodeAtPoint:touchLocation];
        
        if ([touch tapCount] == 1) {
            LineNode *lineNode = (LineNode *)touchedNode.parent;
            if(touchedNode.alpha == 0) {
                lineNode.isMine = YES;
                lineNode.connected = YES;
                SKAction *fadeIn = [SKAction fadeInWithDuration:.1];
                [touchedNode runAction:fadeIn];
            }
//            } else {
//                lineNode.isMine = YES;
//                lineNode.connected = NO;
//                SKAction *fadeOut = [SKAction fadeOutWithDuration:.1];
//                [touchedNode runAction:fadeOut];
//            }
        }
//        self.board.isMe = NO;
    }
//    } else {
//        UITouch *touch = [touches anyObject];
//        CGPoint touchLocation = [touch locationInNode:self];
//        SKNode *touchedNode = [self nodeAtPoint:touchLocation];
//        
//        if ([touch tapCount] == 1) {
//            LineNode *lineNode = (LineNode *)touchedNode.parent;
//            lineNode.connected = YES;
//            lineNode.isMine = NO;
//            if(touchedNode.alpha == 0) {
//                SKAction *fadeIn = [SKAction fadeInWithDuration:.1];
//                [touchedNode runAction:fadeIn];
//            } else {
//                SKAction *fadeOut = [SKAction fadeOutWithDuration:.1];
//                [touchedNode runAction:fadeOut];
//            }
//        }
//        self.board.isMe = YES;
//    }
}

- (void)setIsMine:(BOOL)isMine
{
    _isMine = isMine;
    self.lineSprite.isMine = isMine;
}

- (void)setConnected:(BOOL)connected
{
    _connected = connected;
    [self.board lineNode:self didChangeState:YES];
}

@end
