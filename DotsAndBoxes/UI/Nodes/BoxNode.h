//
//  BoxNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/15/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LineNode.h"

@interface BoxNode : SKNode
@property(weak, nonatomic) LineNode *left;
@property(weak, nonatomic) LineNode *right;
@property(weak, nonatomic) LineNode *up;
@property(weak, nonatomic) LineNode *down;

@end
