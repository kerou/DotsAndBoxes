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
        
//        SKShader* shader = [SKShader shaderWithFileNamed:@"ether.fsh"];
//        //Set vairiables that are used in the shader script
//        shader.uniforms = @[
//                            [SKUniform uniformWithName:@"size" floatVector3:GLKVector3Make(self.frame.size.width, self.frame.size.height, 0)],
//                            ];
//        //add the shader to the sprite
//        self.shader = shader;
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
    {
        UIGraphicsBeginImageContext(CGSizeMake(4*size,size));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIColor *allyColor = [UIColor colorWithRed:.98 green:.59 blue:.41 alpha:1];
        CGContextSetFillColorWithColor(ctx, allyColor.CGColor);

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);

        CGPathAddCurveToPoint(path, NULL, 0.5*size, size/30, 0.5*size, size/3, size, size/3);
        CGPathAddLineToPoint(path, NULL, 3*size, size/3);
        CGPathAddCurveToPoint(path, NULL, 3.5*size, size/3, 3.5*size, size/30, 4*size, 0);
        CGPathAddLineToPoint(path, NULL, 4*size, size);
        CGPathAddCurveToPoint(path, NULL, 3.5*size, size, 3.5*size, 2*size/3, 3*size, 2*size/3);
        CGPathAddLineToPoint(path, NULL, size, 2*size/3);
        CGPathAddCurveToPoint(path, NULL, 0.5*size, 2*size/3, 0.5*size, size, 0, size);
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
        UIGraphicsBeginImageContext(CGSizeMake(4*size,size));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIColor *opponentColor = [UIColor colorWithRed:.27 green:.69 blue:.85 alpha:1];
        CGContextSetFillColorWithColor(ctx, opponentColor.CGColor);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        
        CGPathAddCurveToPoint(path, NULL, 0.5*size, size/30, 0.5*size, size/3, size, size/3);
        CGPathAddLineToPoint(path, NULL, 3*size, size/3);
        CGPathAddCurveToPoint(path, NULL, 3.5*size, size/3, 3.5*size, size/30, 4*size, 0);
        CGPathAddLineToPoint(path, NULL, 4*size, size);
        CGPathAddCurveToPoint(path, NULL, 3.5*size, size, 3.5*size, 2*size/3, 3*size, 2*size/3);
        CGPathAddLineToPoint(path, NULL, size, 2*size/3);
        CGPathAddCurveToPoint(path, NULL, 0.5*size, 2*size/3, 0.5*size, size, 0, size);
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
