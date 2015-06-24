//
//  DBGameContainerViewController.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/23/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DBGameContainerViewController.h"

@interface DBGameContainerViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation DBGameContainerViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:@"bg.paperjam.dotsandboxes.gameOver" object:nil];
    
    GameViewController *gameViewController = [self.childViewControllers objectAtIndex:0];
    gameViewController.boardSize = self.boardSize;
    gameViewController.isMe = self.isMe;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)gameOver
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
