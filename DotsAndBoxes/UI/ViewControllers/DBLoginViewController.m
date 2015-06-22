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

@interface DBLoginViewController ()
@property (strong, nonatomic) NSDictionary *credentials;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
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
    [self.loginButton setEnabled:NO];
    [self.registerButton setEnabled:NO];
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidesWhenStopped:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if(![self.userNameTextField.text isEqualToString:@""] && ![self.passwordTextField.text isEqualToString:@""]) {
        self.credentials = @{@"user" : self.userNameTextField.text, @"pass" : self.passwordTextField.text};
        [self.socket emit:@"login" withItems:@[@{@"user" : self.credentials[@"user"], @"pass" : self.credentials[@"pass"]}]
         ];
    }
}
- (IBAction)register:(id)sender {
    [self.loginButton setEnabled:NO];
    [self.registerButton setEnabled:NO];
    [self.activityIndicator startAnimating];
    [[AppDelegate getInstance] initializeSocket:self];
    
    
//    [self.socket emit:@"disconnectUser" withItems:@[@{@"userId" : [NSNumber numberWithInteger:[AppDelegate getInstance].userId]}]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"socket"]) {
        if(self.socket) {
            NSLog(@"connection established");
            [self.loginButton setEnabled:YES];
            [self.registerButton setEnabled:YES];
            [self.activityIndicator stopAnimating];
        }
    }
    
    if([keyPath isEqualToString:@"players"]) {
        NSLog(@"");
    }
}




@end
