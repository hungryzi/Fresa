//
//  ViewPhrasesViewController.m
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "ViewPhrasesViewController.h"
#import "Phrase.h"
#import "AddPhraseViewController.h"
#import "PlayPhrasesViewController.h"

@interface ViewPhrasesViewController ()

@property (strong) UITableView *tableView;
@property (strong) UIToolbar *toolbar;
@property (copy) NSArray *phrases;
@property (strong) UIButton *addButton;

@end

@implementation ViewPhrasesViewController

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
    
    self.title = @"All";
    
    [self loadFromDisk];
    [self setupTableView];
    [self setupAddButton];
    [self setupToolBar];
}

- (void)setupAddButton
{
    self.addButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addButton setTitle: @"Add" forState: UIControlStateNormal];
    [self.addButton sizeToFit];

    [self.addButton addTarget: self action: @selector(addButtonTapped:) forControlEvents: UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(addingPhraseNotification:) name: @"addingPhrase" object: nil];
}

- (void)setupToolBar
{
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playAction:)];

    NSArray* toolbarItems = [NSArray arrayWithObjects: flexibleSpace, playButton, nil];
    
    self.toolbarItems = toolbarItems;
    self.navigationController.toolbarHidden = NO;
}

- (void) playAction: (UIButton *) button
{
    PlayPhrasesViewController *playViewController = [[PlayPhrasesViewController alloc] init];
    [self.navigationController pushViewController: playViewController animated: YES];
}

- (void) addButtonTapped: (UIButton *) button {
    AddPhraseViewController *addViewController = [[AddPhraseViewController alloc] init];
    [self.navigationController pushViewController: addViewController animated: YES];
}

- (void) addingPhraseNotification: (NSNotification *) notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *original = userInfo[@"original"];
    NSString *meaning = userInfo[@"meaning"];
    [self addPhraseWithOriginal:original andMeaning:meaning];
}

- (void) viewWillAppear:(BOOL)animated {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.addButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) addPhraseWithOriginal: (NSString *)original andMeaning: (NSString *)meaning
{
    if ([original isEqualToString: @""])
        return;

    Phrase *phrase = [[Phrase alloc] initWithOriginal:original meaning:meaning];
    [self insertPhrase: phrase];

    [self saveToDisk];
}

- (void)insertPhrase: (Phrase *) phrase
{
    [self insertToDataSource: phrase];
    [self insertRowOnTop];
}

- (void)insertToDataSource: (Phrase *) phrase
{
    NSMutableArray *mutableArray = [NSMutableArray new];
    [mutableArray addObject: phrase];
    [mutableArray addObjectsFromArray: self.phrases];
    self.phrases = mutableArray;
}

- (void)insertRowOnTop
{
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForRow: 0 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)deleteFromDataSource: (NSInteger) index
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray: self.phrases];
    [mutableArray removeObjectAtIndex: index];
    self.phrases = mutableArray;
}

- (void)deleteRowAt: (NSIndexPath *) index
{
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: index] withRowAnimation: UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"UITableViewCell" ];
    [self.view addSubview: self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.phrases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"UITableViewCell"];
    Phrase *phrase = [self.phrases objectAtIndex: indexPath.row];
    cell.textLabel.text = phrase.original;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle != UITableViewCellEditingStyleDelete)
        return;

    [self deleteFromDataSource: indexPath.row];
    [self deleteRowAt: indexPath];
    [self saveToDisk];
}

- (void) saveToDisk
{
    NSMutableDictionary *toSaved = [NSMutableDictionary new];

    [self.phrases enumerateObjectsUsingBlock:^(Phrase *phrase, NSUInteger idx, BOOL *stop) {
        [toSaved setObject:phrase.original forKey:phrase.meaning];
    }];

    [[NSUserDefaults standardUserDefaults] setObject: toSaved forKey: @"phrases"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
