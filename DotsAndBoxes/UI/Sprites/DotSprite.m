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
    }
    return self;
}


//+ (void)generateDotTextureWithSize:(CGFloat)size
//{
//    UIGraphicsBeginImageContext(CGSizeMake(size,size));
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//////    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:.85 green:.84 blue:.83 alpha:1.0].CGColor);
//////    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
////    CGContextFillRect(ctx, CGRectMake(0,0,size,size));
////    CGRect holeRectIntersection = CGRectMake(0,0,size,size);
////    CGContextAddEllipseInRect(ctx, holeRectIntersection);
////    CGContextClip(ctx);
////    CGContextClearRect(ctx, holeRectIntersection);
////    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
////    CGContextFillRect(ctx, holeRectIntersection);
////    
////    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
////    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, size,size));
//    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
//    CGContextRelease(ctx);
//
//    dotTexture = [SKTexture textureWithImage:textureImage];
//}

+ (void)generateDotTextureWithSize:(CGFloat)size
{
    CGFloat textureSize = 4*size;
    UIGraphicsBeginImageContext(CGSizeMake(textureSize, textureSize));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor darkGrayColor].CGColor);
    //    CGContextFillRect(ctx, CGRectMake(0,0,4*size,size));
    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, textureSize, textureSize));
    
    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease(ctx);
    
    dotTexture = [SKTexture textureWithImage:textureImage];
}

@end
