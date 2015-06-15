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


@property(strong, nonatomic) DotNode *dotNode;
@property(assign, nonatomic) NSUInteger row;
@property(assign, nonatomic) NSUInteger column;

- (id)initWithRow:(NSUInteger)row andColumn:(NSUInteger)column;
@end
