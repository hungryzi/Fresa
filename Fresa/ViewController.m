//
//  ViewController.m
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "ViewController.h"
#import "ViewPhrasesViewController.h"

@interface ViewController ()

@property ViewPhrasesViewController *viewPhrasesViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewPhrasesViewController = [ViewPhrasesViewController new];
    
    // Navigation view
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: self.viewPhrasesViewController];
    
    [self.view addSubview: navigationController.view];

    // TODO: remove this
    navigationController.view.layer.borderColor = [UIColor redColor].CGColor;
    navigationController.view.layer.borderWidth = 1;
    
    [self addChildViewController: navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
