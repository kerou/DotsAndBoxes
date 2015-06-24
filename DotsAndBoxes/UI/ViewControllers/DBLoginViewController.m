//
//  DBLoginViewController.m
//  DotsAndBoxes
//
//  Created by Ivo Kanchev on 6/22/15.
//  Copyright (c) 2015 bg.paperjam. All rights reserved.
//

#import "DBLoginViewController.h"
#import "DotsAndBoxes-Swift.h"
#import "AppDelegate.h"
#import "DBPlayersTableViewController.h"

@interface DBLoginViewController ()
@property (strong, nonatomic) NSDictionary *credentials;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *chooseUserLabel;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) SocketIOClient *socket;
@property (strong, nonatomic) NSMutableArray *players;
@end

@implementation DBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AppDelegate getInstance] initializeSocket:self];
    [self addObserver:self forKeyPath:@"socket" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"players" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activityIndicator setHidesWhenStopped:YES];
    [self.activityIndicator startAnimating];

    if(!self.credentials) {
        self.userNameTextField.hidden = NO;
        self.chooseUserLabel.hidden = NO;
        self.loginButton.hidden = NO;
        self.disconnectButton.hidden = YES;
    } else {
        self.chooseUserLabel.hidden = YES;
        self.userNameTextField.hidden = YES;
        self.loginButton.hidden = NO;
        self.disconnectButton.hidden = NO;
        [self.activityIndicator stopAnimating];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"socket"];
    [self removeObserver:self forKeyPath:@"players"];
}

- (IBAction)login:(id)sender {
    if(!self.credentials) {
        if(![self.userNameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
            self.credentials = @{@"user" : self.userNameTextField.text};
            [self.socket emit:@"login" withItems:@[@{@"user" : self.credentials[@"user"]}]];
        }
    } else {
        [self.socket emit:@"getAvailablePlayers" withItems:@[[AppDelegate getInstance].userId]];
    }
}
- (IBAction)register:(id)sender {
    [[AppDelegate getInstance] disconnect];
    self.credentials = nil;
    [UIView animateWithDuration:.5 animations:^{
        self.userNameTextField.hidden = NO;
        self.chooseUserLabel.hidden = NO;
        self.loginButton.hidden = NO;
        self.disconnectButton.hidden = YES;

    }];    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"socket"]) {
        if(self.socket) {
            NSLog(@"connection established");
            [self.loginButton setEnabled:YES];
            [self.disconnectButton setEnabled:YES];
            [self.activityIndicator stopAnimating];
        }
    }
    
    if([keyPath isEqualToString:@"players"]) {
        [self presentPlayersTableViewController];
    }
}

- (void)presentPlayersTableViewController
{
    if(!self.presentedViewController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *playersNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"playerNavigationViewController"];
        DBPlayersTableViewController *playerTableViewController = (DBPlayersTableViewController *)playersNavigationViewController.topViewController;
        playerTableViewController.players = self.players;
        [self presentViewController:playersNavigationViewController animated:YES completion:^{
            
        }];
    } else {
        UINavigationController *nc = (UINavigationController*)self.presentedViewController;
        [nc.topViewController setValue:self.players forKey:@"players"];
    }
}




@end
