//
//  BoardNode.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "BoardNode.h"


@interface BoardNode() <UIAlertViewDelegate>
@property(assign, nonatomic) NSUInteger dimension;
@property(assign, nonatomic) CGFloat circleDiameter;
@property(assign, nonatomic) NSUInteger allBoxes;
@property(strong, nonatomic) NSMutableArray *dotNodes;
@property(strong, nonatomic) SKShader *dotShader;
@property(strong, nonatomic) SKShader *lineShader;

@property(strong, nonatomic) UIAlertView *gameOverAlert;
@end

@implementation BoardNode

- (id)initWithDimension:(NSUInteger)dimension andBoardSize:(CGSize)boardSize;
{
    if(self = [super init]) {
        // Notification Center
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerCreatedLine:) name:@"bg.paperjam.dotsandboxes.playercreatedline" object:nil];
        
                
        self.dotNodes = [NSMutableArray new];
        self.dimension = dimension;
        self.boardSize = boardSize;
        self.allBoxes = (self.dimension - 1)*(self.dimension -1);
        self.circleDiameter = self.boardSize.width/(4*dimension-3);
        
        // Textures
        [DotSprite generateDotTextureWithSize:self.circleDiameter];
        [LineSprite generatelineTextureWithSize:self.circleDiameter];
        
        // Shaders
        self.dotShader = [SKShader shaderWithFileNamed:@"eclipse.fsh"];
        [self.dotShader addUniform:[SKUniform uniformWithName:@"name" floatVector3:GLKVector3Make(self.circleDiameter, self.circleDiameter, 0)]];
        self.lineShader = [SKShader shaderWithFileNamed:@"sinusoid.fsh"];
//        [self.lineShader addUniform:[SKUniform uniformWithName:@"name" floatVector3:GLKVector3Make(self.circleDiameter, self.circleDiameter, 0)]];

        self.position = CGPointMake(self.circleDiameter/2, self.circleDiameter/2);
        
        for (int row=0; row<self.dimension; row++) {
            NSMutableArray *currentRow = [NSMutableArray new];
            for (int col=0; col<self.dimension; col++) {
                DotNode *dot = [[DotNode alloc] initWithSize:self.circleDiameter row:row andColumn:col];
//                dot.dotSprite.shader = self.dotShader;
                [self addChild:dot];
                [currentRow addObject:dot];
            }
            [self.dotNodes addObject:currentRow];
        }
        
        for (int rowIdx=0; rowIdx<self.dotNodes.count; rowIdx++) {
            NSMutableArray *row = self.dotNodes[rowIdx];
            for (int colIdx=0; colIdx<row.count; colIdx++) {
                    DotNode *currentDot = row[colIdx];
                if (colIdx < row.count - 1) {
                    DotNode *secondDot = row[colIdx + 1];
                    LineNode *line = [[LineNode alloc] initWithPosition:currentDot.dotSprite.position size:currentDot.dotSize andOrientation:NO];
//                    line.lineSprite.shader = self.lineShader;
                    line.dot = currentDot;
                    line.board = self;
                    currentDot.rightLine = line;
                    secondDot.leftLine = line;
                    [self addChild:line];
                }
                if (rowIdx < self.dotNodes.count - 1) {
                    DotNode *upperDot = self.dotNodes[rowIdx + 1][colIdx];
                    LineNode *line = [[LineNode alloc] initWithPosition:currentDot.dotSprite.position size:currentDot.dotSize andOrientation:YES];
//                    line.lineSprite.shader = self.lineShader;
                    currentDot.upLine = line;
                    line.dot = currentDot;
                    line.board = self;
                    upperDot.downLine = line;
                    [self addChild:line];
                }
            }
        }
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    CGFloat boxSize = fabs(dot.dotSprite.position.x - diagonalDot.dotSprite.position.x);
    CGSize size = CGSizeMake(boxSize, boxSize);
    SKSpriteNode *box = nil;
    if(isMe) {
        self.allyBoxCount ++;
        box = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:.87 green:.50 blue:.35 alpha:1.] size:size];
    } else {
        self.opponentBoxCount++;
        box = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:.23 green:.62 blue:.73 alpha:1.] size:size];
    }
    
    CGFloat xOffset = 0;
    CGFloat yOffset = 0;
    if(dot.dotSprite.position.x < diagonalDot.dotSprite.position.x) {
        xOffset+=size.width/2;
    } else {
        xOffset-=size.width/2;
    }
    if(dot.dotSprite.position.y < diagonalDot.dotSprite.position.y) {
        yOffset+=size.width/2;
    } else {
        yOffset-=size.width/2;
    }
    box.position = CGPointMake(dot.dotSprite.position.x+xOffset, dot.dotSprite.position.y+yOffset);
    box.alpha = 0;
    box.zPosition = -2;
    [self addChild:box];
    SKAction *fadeIn = [SKAction fadeInWithDuration:.2];
    [box runAction:fadeIn];
    
    if (self.allyBoxCount > (self.allBoxes + 1)/2) {
        self.gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You Win!" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.gameOverAlert show];
    }
    if (self.opponentBoxCount > (self.allBoxes + 1)/2) {
        self.gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You Lose!" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self.gameOverAlert show];
    }
}

#pragma mark - NSNotificationCenter
- (void)playerCreatedLine:(NSNotification *)notification
{
    NSLog(@"Player Created Line");
    NSDictionary *lineInfo = notification.object;
    NSUInteger row = [lineInfo[@"row"] integerValue];
    NSUInteger col = [lineInfo[@"column"] integerValue];
    BOOL isVertical = [lineInfo[@"isVertical"] boolValue];
    
    DotNode *dot = self.dotNodes[row][col];
    LineNode *line = isVertical ? dot.upLine : dot.rightLine;
    line.lineSprite.isAlly = NO;
    line.connected = YES;
}

#pragma mark - Alert View Delegate Methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bg.paperjam.dotsandboxes.gameOver" object:nil];
}
@end
