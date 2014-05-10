//
//  AddPhraseViewController.m
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "AddPhraseViewController.h"
#import "AddPhraseMeaningViewController.h"

@interface AddPhraseViewController ()

@property UITextField *textField;
@property UIButton *continueButton;

@end

@implementation AddPhraseViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"New phrase";

    [self setupTextField];
    [self setupNextLabel];
}

- (void)setupTextField
{
    self.textField = [[UITextField alloc] initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, 320, 40)];
    self.textField.backgroundColor = [UIColor blueColor];
    [self.view addSubview: self.textField];
}

- (void)setupNextLabel
{
    self.continueButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
    [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.continueButton setTitle: @"Next" forState: UIControlStateNormal];
    [self.continueButton sizeToFit];
    [self.continueButton addTarget: self action: @selector(continueButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
}

- (void) continueButtonTapped: (UITapGestureRecognizer *) gesture {
    AddPhraseMeaningViewController *addViewController = [[AddPhraseMeaningViewController alloc] initWithOriginal: self.textField.text];

    [self.navigationController pushViewController: addViewController animated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.continueButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
