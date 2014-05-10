//
//  AddPhraseMeaningViewController.m
//  Fresa
//
//  Created by Zi on 11/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "AddPhraseMeaningViewController.h"

@interface AddPhraseMeaningViewController ()

@property UITextField *textField;
@property UIButton *continueButton;
@property NSString *original;

@end

@implementation AddPhraseMeaningViewController

- (id)initWithOriginal: (NSString *) original
{
    self = [self init];

    self.original = original;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Meaning";

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
    [self.continueButton setTitle: @"Save" forState: UIControlStateNormal];
    [self.continueButton sizeToFit];
    [self.continueButton addTarget: self action: @selector(continueButtonTapped:) forControlEvents: UIControlEventTouchUpInside];
}

- (void) continueButtonTapped: (UITapGestureRecognizer *) gesture {
    NSDictionary *userInfo = @{
      @"original": self.original,
      @"meaning": self.textField.text
    };

    [[NSNotificationCenter defaultCenter] postNotificationName: @"addingPhrase" object: nil userInfo:userInfo];
    [self.navigationController popToRootViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
