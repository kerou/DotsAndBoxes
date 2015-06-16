//
//  BoardNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "BoardNode.h"
#import "DotNode.h"
#import "BoxNode.h"

@interface BoardNode()
@property(assign, nonatomic) NSUInteger dimension;
@property(assign, nonatomic) CGFloat circleDiameter;
@property(assign, nonatomic) NSUInteger allBoxes;
@property(strong, nonatomic) NSMutableArray *dotNodes;
@end

@implementation BoardNode

- (id)initWithDimension:(NSUInteger)dimension andBoardSize:(CGSize)boardSize;
{
    if(self = [super init]) {
        self.dotNodes = [NSMutableArray new];
        self.dimension = dimension;
        self.boardSize = boardSize;
        self.allBoxes = (self.dimension - 1)*(self.dimension -1);
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
                    DotNode *secondDot = row[[row indexOfObject:dot]+1];
                    LineNode *line = [[LineNode alloc] initWithPosition:dot.position size:dot.dotSize andOrientation:NO];
                    line.dot = dot;
                    line.board = self;
                    dot.rightLine = line;
                    secondDot.leftLine = line;
                    [self addChild:line];
                }
                if (row != [self.dotNodes lastObject]) {
                    NSMutableArray *upperRow = self.dotNodes[[self.dotNodes indexOfObject:row] + 1];
                    DotNode *upperDot = upperRow[[row indexOfObject:dot]];
                    LineNode *line = [[LineNode alloc] initWithPosition:dot.position size:dot.dotSize andOrientation:YES];
                    dot.upLine = line;
                    line.dot = dot;
                    line.board = self;
                    upperDot.downLine = line;
                    [self addChild:line];
                }
            }
        }
        
//        SKLightNode* light = [[SKLightNode alloc] init];
//        light.categoryBitMask = 1;
//        light.falloff = 1;
//        light.ambientColor = [UIColor whiteColor];
//        light.lightColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:0.0 alpha:0.5];
//        light.shadowColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
//        light.position = CGPointMake(0, 0);
//        [self addChild:light];
    }
    return self;
}

- (void)setIsMe:(BOOL)isMe
{
    _isMe = isMe;
    if(self.isMe) {
        self.userInteractionEnabled = YES;
    } else {
        self.userInteractionEnabled = NO;
    }
}

- (void)lineNode:(LineNode *)line didChangeState:(BOOL)isConnected
{
    DotNode *dot = line.dot;
    BOOL shouldChangePlayer = YES;
    if(line.isVertical) {
        if(dot.leftLine && dot.leftLine.connected) {
            DotNode *diagonalNode = self.dotNodes[dot.row + 1][dot.column - 1];
            if(diagonalNode.downLine && diagonalNode.downLine.connected && diagonalNode.rightLine && diagonalNode.rightLine.connected) {
                [self createBox:dot diagonalDot:diagonalNode andPlayer:[self isMe]];
                shouldChangePlayer = NO;
            }
        }
        if(dot.rightLine && dot.rightLine.connected) {
            DotNode *diagonalNode = self.dotNodes[dot.row + 1][dot.column + 1];
            if(diagonalNode.downLine && diagonalNode.downLine.connected && diagonalNode.leftLine && diagonalNode.leftLine.connected) {
                [self createBox:dot diagonalDot:diagonalNode andPlayer:[self isMe]];
                shouldChangePlayer = NO;
            }
        }
    } else {
        if(dot.upLine && dot.upLine.connected) {
            DotNode *diagonalNode = self.dotNodes[dot.row + 1][dot.column + 1];
            if(diagonalNode.leftLine && diagonalNode.leftLine.connected && diagonalNode.downLine && diagonalNode.downLine.connected) {
                [self createBox:dot diagonalDot:diagonalNode andPlayer:[self isMe]];
                shouldChangePlayer = NO;
            }
        }
        if(dot.downLine && dot.downLine.connected) {
            DotNode *diagonalNode = self.dotNodes[dot.row - 1][dot.column + 1];
            if(diagonalNode.upLine && diagonalNode.upLine.connected && diagonalNode.leftLine && diagonalNode.leftLine.connected) {
                [self createBox:dot diagonalDot:diagonalNode andPlayer:[self isMe]];
                shouldChangePlayer = NO;
            }
        }
    }
    self.isMe = shouldChangePlayer? !self.isMe:self.isMe;
}

- (void)createBox:(DotNode *)dot diagonalDot:(DotNode *)diagonalDot andPlayer:(BOOL)isMe
{
    CGFloat boxSize = fabs(dot.position.x - diagonalDot.position.x);
    CGSize size = CGSizeMake(boxSize, boxSize);
    SKSpriteNode *box = nil;
    if(isMe) {
        self.allyBoxCount +=1;
        box = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:.87 green:.50 blue:.35 alpha:1.] size:size];
    } else {
        box = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:.23 green:.62 blue:.73 alpha:1.] size:size];
    }
    
    CGFloat xOffset = 0;
    CGFloat yOffset = 0;
    if(dot.position.x < diagonalDot.position.x) {
        xOffset+=size.width/2;
    } else {
        xOffset-=size.width/2;
    }
    if(dot.position.y < diagonalDot.position.y) {
        yOffset+=size.width/2;
    } else {
        yOffset-=size.width/2;
    }
    box.position = CGPointMake(dot.position.x+xOffset, dot.position.y+yOffset);
    box.alpha = 0;
    box.zPosition = -2;
    [self addChild:box];
    SKAction *fadeIn = [SKAction fadeInWithDuration:.2];
    [box runAction:fadeIn];
}
@end
