//
//  BoardNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "BoardNode.h"
#import "DotNode.h"
#import "LineNode.h"
@interface BoardNode()
@property(assign, nonatomic) NSUInteger dimension;
@property(assign, nonatomic) CGFloat circleDiameter;
@property(strong, nonatomic) NSMutableArray *dotNodes;
@property(strong, nonatomic) NSMutableArray *lineNodes;
@end

@implementation BoardNode

- (id)initWithDimension:(NSUInteger)dimension andBoardSize:(CGSize)boardSize;
{
    if(self = [super init]) {
        self.enabled = YES;
        self.dotNodes = [NSMutableArray new];
        self.dimension = dimension;
        self.boardSize = boardSize;
        self.circleDiameter = self.boardSize.width/(4*dimension-3);
        
        [DotSprite generateDotTextureWithSize:self.circleDiameter];
        [LineSprite generatelineTextureWithSize:self.circleDiameter];

    
        self.position = CGPointMake(self.circleDiameter/2, self.circleDiameter/2);
        
        for (int row=0; row<self.dimension; row++) {
            NSMutableArray *currentRow = [NSMutableArray new];
            for (int col=0; col<self.dimension; col++) {
                DotNode *dot = [[DotNode alloc] initWithSize:self.circleDiameter row:row andColumn:col];
                [self addChild:dot];
                [currentRow addObject:dot];
            }
            [self.dotNodes addObject:currentRow];
        }
        
        for (NSMutableArray *row in self.dotNodes) {
            for (DotNode *dot in row) {
                if (dot != [row lastObject]) {
                    LineNode *line = [[LineNode alloc] initWithDotNode:dot andSecond:row[[row indexOfObject:dot]+1]];
                    [self.lineNodes addObject:line];
                    [self addChild:line];
                }
                if (row != [self.dotNodes lastObject]) {
                    NSMutableArray *bottomRow = self.dotNodes[[self.dotNodes indexOfObject:row] + 1];
                    DotNode *bottomDot = bottomRow[[row indexOfObject:dot]];
                    LineNode *line = [[LineNode alloc] initWithDotNode:dot andSecond:bottomDot];
                    [self.lineNodes addObject:line];
                    [self addChild:line];
                }
            }
        }
        
//        for (NSMutableArray *row in dots) {
//            for (Dot *dot in row) {
//                if(![dot isEqual:[row lastObject]]) {
//                    LineSprite *line = [[LineSprite alloc] initWithSize:self.circleDiameter];
////                    line.color = [UIColor blueColor];
//                    line.zPosition = -1;
//                    line.position = CGPointMake(dot.sprite.position.x+2*dot.sprite.size.width, dot.sprite.position.y);
//                    line.size = CGSizeMake(self.circleDiameter*4, self.circleDiameter);
//                    [self addComponent:line];
//                }
//                
//                if(![row isEqual:[dots lastObject]]) {
//                    LineSprite *line = [[LineSprite alloc] initWithSize:self.circleDiameter];
////                    line.color = [UIColor blueColor];
//                    line.zPosition = -1;
//                    line.position = CGPointMake(dot.sprite.position.x, dot.sprite.position.y + self.circleDiameter*2);
//                    line.size = CGSizeMake(self.circleDiameter*4, self.circleDiameter);
//                    line.zRotation = M_PI_2;
//                    [self addComponent:line];
//                }
//            }
//        }
    }
    return self;
}

- (void)awake
{
    NSLog(@"BOARD AWAKE!");
}





@end
