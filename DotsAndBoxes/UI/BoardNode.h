//
//  BoardNode.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BoardNode : SKNode

@property(readwrite, nonatomic) BOOL enabled;

@property(assign, nonatomic) CGSize boardSize;

- (id)initWithDimension:(NSUInteger)dimension andBoardSize:(CGSize)boardSize;
@end
