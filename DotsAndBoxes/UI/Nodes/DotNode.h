//
//  DotNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DotSprite.h"
#import "LineNode.h"

@interface DotNode : SKNode
@property(strong, nonatomic) DotSprite *dotSprite;
@property(weak, nonatomic) LineNode *leftLine;
@property(weak, nonatomic) LineNode *rightLine;
@property(weak, nonatomic) LineNode *upLine;
@property(weak, nonatomic) LineNode *downLine;
@property(assign, nonatomic) CGFloat dotSize;
@property(assign, nonatomic) NSUInteger row;
@property(assign, nonatomic) NSUInteger column;

- (id)initWithSize:(CGFloat)size row:(NSUInteger)row andColumn:(NSUInteger)col;

@end
