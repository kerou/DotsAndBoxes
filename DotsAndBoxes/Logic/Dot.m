//
//  Dot.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "Dot.h"

@interface Dot()
@end

@implementation Dot

- (id)init
{
    if(self = [super init]) {
        self.connectionsState = DotNotConnected;
        self.row = NSUIntegerMax;
        self.column = NSUIntegerMax;
        
    }
    return self;
}

- (id)initWithRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if(self = [super init]) {
        self.connectionsState = DotNotConnected;
        self.row = row;
        self.column = column;
    }
    return self;
}

@end
