//
//  LineNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "LineNode.h"

@implementation LineNode

- (id)initWithDotNode:(DotNode *)firstDotNode andSecond:(DotNode *)secondDotNode
{
    if(self = [super init]) {
        self.userInteractionEnabled = YES;
        self.firstDot = firstDotNode;
        self.secondDot = secondDotNode;
        self.lineSprite = [[LineSprite alloc] initWithSize:self.firstDot.dotSize];
        if (self.firstDot.position.x == self.secondDot.position.x) {
            self.position = CGPointMake(self.firstDot.position.x, self.firstDot.position.y + 2*self.firstDot.dotSize);
            self.lineSprite.zRotation = M_PI_2;
        } else {
            self.position = CGPointMake(self.firstDot.position.x + 2*self.firstDot.dotSize, self.firstDot.position.y);
        }
        [self addChild:self.lineSprite];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *touchedNode = [self nodeAtPoint:touchLocation];
    
    if ([touch tapCount] == 1) {
        NSLog(@"Crate node has been touched. Single tap.");
        if(touchedNode.alpha == 0) {
            SKAction *fadeIn = [SKAction fadeInWithDuration:.1];
            [touchedNode runAction:fadeIn];
        } else {
            SKAction *fadeOut = [SKAction fadeOutWithDuration:.1];
            [touchedNode runAction:fadeOut];
        }
    }
}

@end
