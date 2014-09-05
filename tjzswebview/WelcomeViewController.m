//
//  WelcomeViewController.m
//  tjzswebview
//
//  Created by buffer on 14-7-11.
//  Copyright (c) 2014年 com.Intel.Avatar. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showNextView) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNextView
{
    [self performSegueWithIdentifier:@"showMainView" sender:self];
}

@end
