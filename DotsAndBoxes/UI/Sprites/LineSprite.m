    //
//  LineSprite.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "LineSprite.h"

static SKTexture *lineTextureAlly;
static SKTexture *lineTextureOpponent;

@interface LineSprite()

@property(assign, nonatomic) CGFloat lineSpriteSize;
@end

@implementation LineSprite

- (id)initWithSize:(CGFloat)dotSize
{
    if(self = [super init]) {
        self.userInteractionEnabled = YES;
        self.alpha = 0;
        self.lineSpriteSize = dotSize;
        self.texture = lineTextureAlly;
        self.size = CGSizeMake(4*self.lineSpriteSize, self.lineSpriteSize);
        self.zPosition = -1;
    }
    return self;
}

- (void)setIsMe:(BOOL)isMe
{
    _isMe = isMe;
    if(isMe) {
        self.texture = lineTextureAlly;
    } else {
        self.texture = lineTextureOpponent;
    }
}

+ (void)generatelineTextureWithSize:(CGFloat)size
{
    CGFloat textureSize = 4*size;
    {
        UIGraphicsBeginImageContext(CGSizeMake(4*textureSize,textureSize));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIColor *allyColor = [UIColor colorWithRed:.98 green:.59 blue:.41 alpha:1];
        CGContextSetFillColorWithColor(ctx, allyColor.CGColor);

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);

        CGPathAddCurveToPoint(path, NULL, 0.5*textureSize, textureSize/30, 0.5*textureSize, textureSize/3, textureSize, textureSize/3);
        CGPathAddLineToPoint(path, NULL, 3*textureSize, textureSize/3);
        CGPathAddCurveToPoint(path, NULL, 3.5*textureSize, textureSize/3, 3.5*textureSize, textureSize/30, 4*textureSize, 0);
        CGPathAddLineToPoint(path, NULL, 4*textureSize, textureSize);
        CGPathAddCurveToPoint(path, NULL, 3.5*textureSize, textureSize, 3.5*textureSize, 2*textureSize/3, 3*textureSize, 2*textureSize/3);
        CGPathAddLineToPoint(path, NULL, textureSize, 2*textureSize/3);
        CGPathAddCurveToPoint(path, NULL, 0.5*textureSize, 2*textureSize/3, 0.5*textureSize, textureSize, 0, textureSize);
        CGPathAddLineToPoint(path, NULL, 0, 0);
        CGPathCloseSubpath(path);
        CGContextAddPath(ctx, path);
        CGContextFillPath(ctx);
        CGContextSetStrokeColorWithColor(ctx,[UIColor greenColor].CGColor);
        CGContextStrokePath(ctx);
        CGPathRelease(path);

        UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRelease(ctx);
        lineTextureAlly = [SKTexture textureWithImage:textureImage];
    }
    
    {
        UIGraphicsBeginImageContext(CGSizeMake(4*textureSize,textureSize));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIColor *opponentColor = [UIColor colorWithRed:.27 green:.69 blue:.85 alpha:1];
        CGContextSetFillColorWithColor(ctx, opponentColor.CGColor);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        
        CGPathAddCurveToPoint(path, NULL, 0.5*textureSize, textureSize/30, 0.5*textureSize, textureSize/3, textureSize, textureSize/3);
        CGPathAddLineToPoint(path, NULL, 3*textureSize, textureSize/3);
        CGPathAddCurveToPoint(path, NULL, 3.5*textureSize, textureSize/3, 3.5*textureSize, textureSize/30, 4*textureSize, 0);
        CGPathAddLineToPoint(path, NULL, 4*textureSize, textureSize);
        CGPathAddCurveToPoint(path, NULL, 3.5*textureSize, textureSize, 3.5*textureSize, 2*textureSize/3, 3*textureSize, 2*textureSize/3);
        CGPathAddLineToPoint(path, NULL, textureSize, 2*textureSize/3);
        CGPathAddCurveToPoint(path, NULL, 0.5*textureSize, 2*textureSize/3, 0.5*textureSize, textureSize, 0, textureSize);
        CGPathAddLineToPoint(path, NULL, 0, 0);
        CGPathCloseSubpath(path);
        CGContextAddPath(ctx, path);
        CGContextFillPath(ctx);
        CGContextSetStrokeColorWithColor(ctx,[UIColor greenColor].CGColor);
        CGContextStrokePath(ctx);
        CGPathRelease(path);
        
        UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRelease(ctx);
        lineTextureOpponent = [SKTexture textureWithImage:textureImage];
    }
}

@end
