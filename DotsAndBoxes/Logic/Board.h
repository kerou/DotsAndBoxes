//
//  Board.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardNode.h"

@interface Board : NSObject

@property(assign, nonatomic) NSUInteger dimension;
@property(strong, nonatomic) BoardNode *boardComponentNode;
- (id)initWithDimension:(NSUInteger)dim andSize:(CGSize)boardSize;
@end
