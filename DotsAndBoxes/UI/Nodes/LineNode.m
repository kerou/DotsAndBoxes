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
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchLocation];
    
    if ([touch tapCount] == 1 && [touchedNode.parent isMemberOfClass:[LineNode class]]) {
        LineNode *lineNode = (LineNode *)touchedNode.parent;
        if(touchedNode.alpha == 0) {
            lineNode.lineSprite.isMe = self.board.isMe;
            lineNode.connected = YES; 
            SKAction *fadeIn = [SKAction fadeInWithDuration:.1];
            [touchedNode runAction:fadeIn];
        }
    }
    
}

- (void)setConnected:(BOOL)connected
{
    _connected = connected;
    [self.board lineNode:self didChangeState:YES];
}

@end
