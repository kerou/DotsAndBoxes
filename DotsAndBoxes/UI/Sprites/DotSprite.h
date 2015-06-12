//
//  DotSprite.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DotSprite : SKSpriteNode
@property(readwrite, nonatomic) BOOL enabled;
- (id)initWithSize:(CGFloat)size;
+ (void)generateDotTextureWithSize:(CGFloat)size;
@end
