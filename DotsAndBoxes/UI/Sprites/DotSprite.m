//
//  DotSprite.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DotSprite.h"

static SKTexture *dotTexture;

@interface DotSprite()

@end
@implementation DotSprite
- (id)initWithSize:(CGFloat)size
{
    if(self = [super init]) {
        self.size = CGSizeMake(size,size);
//        self.color = [UIColor redColor];
        self.texture = dotTexture;
        SKSpriteNode *shaderSprite = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(self.size.width-2, self.size.height-3)];
        SKShader* shader = [SKShader shaderWithFileNamed:@"blobs.fsh"];
        //Set vairiables that are used in the shader script
        shader.uniforms = @[
                            [SKUniform uniformWithName:@"size" floatVector3:GLKVector3Make(self.frame.size.width, self.frame.size.height, 0)],
                            ];
        self.shader = shader;
//        self.blendMode = SKBlendModeSubtract;
//        add the shader to the sprite
//        self.blendMode = SKBlendModeSubtract;
//        shaderSprite.blendMode = SKBlendModeSubtract;
//        shaderSprite.shader = shader;
//        [self addChild:shaderSprite];
    }
    return self;
}


+ (void)generateDotTextureWithSize:(CGFloat)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size,size));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:.85 green:.84 blue:.83 alpha:1.0].CGColor);
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0,0,size,size));
    CGRect holeRectIntersection = CGRectMake(0,0,size,size);
    CGContextAddEllipseInRect(ctx, holeRectIntersection);
    CGContextClip(ctx);
    CGContextClearRect(ctx, holeRectIntersection);
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextFillRect(ctx, holeRectIntersection);
    
//    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
//    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, size,size));
    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease(ctx);

    dotTexture = [SKTexture textureWithImage:textureImage];
}

//+ (void)generateDotTextureWithSize:(CGFloat)size
//{
//    UIGraphicsBeginImageContext(CGSizeMake(size,size));
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
//    //    CGContextFillRect(ctx, CGRectMake(0,0,4*size,size));
//    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, size,size));
//    
//    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
//    CGContextRelease(ctx);
//    
//    dotTexture = [SKTexture textureWithImage:textureImage];
//}

@end
