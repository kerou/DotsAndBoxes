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
        self.color = [UIColor blueColor];
        self.texture = dotTexture;
    }
    return self;
}


+ (void)generateDotTextureWithSize:(CGFloat)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size,size));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    //    CGContextFillRect(ctx, CGRectMake(0,0,4*size,size));
    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, size,size));

    UIImage *textureImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRelease(ctx);

    dotTexture = [SKTexture textureWithImage:textureImage];
}

@end
