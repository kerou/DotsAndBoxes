//
//  Dot.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DotNode.h"

@interface Dot : NSObject

typedef NS_ENUM(NSUInteger, DotConnectionsState) {
    DotNotConnected,
    DotLeftConnected,
    DotRightConnected,
    DotUpConnected,
    DotDownConnected
};


@property(strong, nonatomic) DotNode *dotNode;
@property(assign, nonatomic) DotConnectionsState connectionsState;
@property(assign, nonatomic) NSUInteger row;
@property(assign, nonatomic) NSUInteger column;

- (id)initWithRow:(NSUInteger)row andColumn:(NSUInteger)column;
@end
