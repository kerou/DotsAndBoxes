//
//  Board.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "Board.h"
#import "Dot.h"

@interface Board()
@property(strong, nonatomic) NSMutableArray *dots;
@end

@implementation Board
- (id)init
{
    if(self = [super init]) {
        self.dots = [NSMutableArray new];
        self.dimension = 5;
        [self prepareBoardForDimension:self.dimension];
    }
    return self;
}

//- (id)initWithDimension:(NSUInteger)dim andSize:(CGSize)boardSize
//{
//    if(self = [super init]) {
//        self.dots = [NSMutableArray new];
//        self.dimension = dim;
//        [self prepareBoardForDimension:self.dimension];
//        self.boardComponentNode = [[BoardNode alloc] initWithDimension:self.dimension dots:self.dots andBoardSize:boardSize];
//    }
//    return self;
//}

- (void)prepareBoardForDimension:(NSUInteger)dim
{
    for (int row=0; row<dim; row++) {
        NSMutableArray *currentRow = [NSMutableArray new];
        for (int col=0; col<dim; col++) {
            Dot *dot = [[Dot alloc] initWithRow:row andColumn:col];
            [currentRow addObject:dot];
        }
        [self.dots addObject:currentRow];
    }
}



@end
