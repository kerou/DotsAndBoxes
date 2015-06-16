//
//  DotNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DotNode.h"

@implementation DotNode
- (id)initWithSize:(CGFloat)size row:(NSUInteger)row andColumn:(NSUInteger)col
{
    if(self = [super init]) {
        self.dotSize = size;
        self.row = row;
        self.column = col;
//        self.position = [self calculatePosition];
        self.dotSprite = [[DotSprite alloc] initWithSize:self.dotSize];
        self.dotSprite.position = [self calculatePosition];
        [self addChild:self.dotSprite];
    }
    return self;
}

- (CGPoint)calculatePosition
{
    return CGPointMake(4*self.column*self.dotSize, 4*self.row*self.dotSize);
}
@end
