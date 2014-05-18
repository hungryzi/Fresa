//
//  PlayPhrasesViewController.m
//  Fresa
//
//  Created by Zi on 13/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "PlayPhrasesViewController.h"
#import "Phrase.h"

@interface PlayPhrasesViewController ()

@property (copy) NSArray *phrases;
@property NSInteger currentIndex;
@property NSInteger phrasesCount;
@property Phrase *currentPhrase;

@property UILabel* originalLabel;
@property UILabel* meaningLabel;

@end

@implementation PlayPhrasesViewController

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

    [self loadFromDisk];
    self.currentIndex = 0;
    [self setupPhrase];

    [self setupLabels];
    [self setupEvents];

    [self showOriginal];
}

- (void)setupPhrase
{
   self.currentPhrase = [self.phrases objectAtIndex: (int)self.currentIndex];
}

- (void)setupEvents
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(viewTapped:)];

    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(viewSwiped:)];
    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionLeft)];

    [self.view addGestureRecognizer: tapGesture];
    [self.view addGestureRecognizer: swipeGesture];
    self.view.userInteractionEnabled = YES;
}

- (void)viewSwiped: (UISwipeGestureRecognizer *) gesture
{
    self.currentIndex = self.currentIndex + 1;

    if (self.currentIndex >= self.phrasesCount) {
        self.currentIndex = 0;
    }

    [self setupPhrase];
    [self showOriginal];
}

- (void)viewTapped: (UITapGestureRecognizer *) gesture
{
    if ([self containsSubview: self.meaningLabel]) {
        [self showOriginal];
    } else {
        [self showMeaning];
    }
}

- (void)showOriginal
{
    if ([self containsSubview: self.meaningLabel]) {
        [self.meaningLabel removeFromSuperview];
    }

    self.meaningLabel.text = self.currentPhrase.meaning;
    self.originalLabel.text = self.currentPhrase.original;

    if (![self containsSubview: self.originalLabel]) {
        [self.view addSubview: self.originalLabel];
    }
}

- (void)showMeaning
{
    if ([self containsSubview: self.originalLabel]) {
        [self.originalLabel removeFromSuperview];
    }

    self.meaningLabel.text = self.currentPhrase.meaning;
    self.originalLabel.text = self.currentPhrase.original;

    if (![self containsSubview: self.meaningLabel]) {
        [self.view addSubview: self.meaningLabel];
    }
}

- (BOOL)containsSubview: (UIView *) subview
{
    return [self.view.subviews containsObject: subview];
}


- (void)setupLabels
{
    self.originalLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 100, 320, 40)];
    self.originalLabel.textAlignment = NSTextAlignmentCenter;

    self.meaningLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 100, 320, 40)];
    self.meaningLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.meaningLabel.numberOfLines = 0;
    self.meaningLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadFromDisk
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey: @"phrases"];
    NSMutableArray *phrases = [NSMutableArray array];

    [dict enumerateKeysAndObjectsUsingBlock: ^(NSString *original, NSString *meaning, BOOL *stop) {
        Phrase *phrase = [[Phrase alloc] initWithOriginal:original meaning:meaning];
        phrase.original = original;
        phrase.meaning = meaning;

        [phrases addObject: phrase];
    }];

    self.phrases = phrases;
    self.phrasesCount = (int)[phrases count];
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
