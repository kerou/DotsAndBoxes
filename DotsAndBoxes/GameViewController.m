//
//  GameViewController.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/10/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "BoardNode.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isMe = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.size = skView.frame.size;
    scene.backgroundColor = [UIColor whiteColor];
    

    BoardNode *board = [[BoardNode alloc] initWithDimension:2 andBoardSize:scene.size];
    board.isMe = YES;
    scene.backgroundColor = [UIColor colorWithRed:.85 green:.84 blue:.83 alpha:1.0];
    
//    SKSpriteNode *shaderSprite = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:scene.size];
//    shaderSprite.size = scene.size;
////    shaderSprite.color = [UIColor whiteColor];
////    shaderSprite.position = CGPointMake(0,0);
//    SKShader* shader = [SKShader shaderWithFileNamed:@"blobs.fsh"];
//    //Set vairiables that are used in the shader script
//    shader.uniforms = @[
//                        [SKUniform uniformWithName:@"size" floatVector3:GLKVector3Make(shaderSprite.size.width, shaderSprite.size.height, 0)],
//                        ];
//    //add the shader to the sprite
//    shaderSprite.shader = shader;
//    shaderSprite.blendMode = SKBlendModeSubtract;
//    
//    [board addChild:shaderSprite];
    
    
    [scene addChild:board];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
