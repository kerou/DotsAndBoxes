//
//  LineSprite.h
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/11/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LineSprite : SKSpriteNode
@property(assign, nonatomic) BOOL isMine;
- (id)initWithSize:(CGFloat)dotSize;

+ (void)generatelineTextureWithSize:(CGFloat)size;
@end
