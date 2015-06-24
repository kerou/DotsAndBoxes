//
//  DBGameTypeViewController.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/23/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DBGameTypeViewController.h"
#import "AppDelegate.h"
#import "DBGameContainerViewController.h"

@interface DBGameTypeViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *gameType;
@property (strong, nonatomic) IBOutlet UIButton *playbutton;
@property (assign, nonatomic) NSNumber *boardSize;
@end

@implementation DBGameTypeViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        self.boardSize = @3;
        self.socket = [AppDelegate getInstance].socket;
    }
    return self;
}
- (IBAction)gameTypeSelected:(id)sender {
    self.boardSize = [NSNumber numberWithLong:self.gameType.selectedSegmentIndex + 3];
}
- (IBAction)play:(id)sender {
    [self.socket emit:@"requestPlay" withItems:@[@{ @"opponentId" : self.opponentId, @"gameType" : self.boardSize, @"requesterId" : [AppDelegate getInstance].userId}]];
    [AppDelegate getInstance].boardSize = [self.boardSize integerValue];
    [AppDelegate getInstance].opponentId = self.opponentId;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
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
