//
//  LineNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DotNode.h"
#import "LineSprite.h"

@interface LineNode : SKNode

@property(strong, nonatomic) LineSprite *lineSprite;
@property(weak, nonatomic) DotNode *firstDot;
@property(weak, nonatomic) DotNode *secondDot;

- (id)initWithDotNode:(DotNode *)firstDotNode andSecond:(DotNode *)secondDotNode;

@end
