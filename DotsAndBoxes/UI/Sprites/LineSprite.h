//
//  LineSprite.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DotNode.h"

@interface LineSprite : SKSpriteNode
@property(readwrite, nonatomic) BOOL enabled;

- (id)initWithSize:(CGFloat)dotSize;

+ (void)generatelineTextureWithSize:(CGFloat)size;
@end
