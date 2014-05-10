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

@interface ViewPhrasesViewController ()

@property (strong) UITableView *tableView;
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
    
    [self setupData];
    [self setupTableView];
    [self setupAddButton];
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

- (void) addButtonTapped: (UIButton *) button {
    AddPhraseViewController *addViewController = [[AddPhraseViewController alloc] init];
    [self.navigationController pushViewController: addViewController animated: YES];
}

- (void) addingPhraseNotification: (NSNotification *) notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *original = userInfo[@"original"];
    [self addPhrase: original];
}

- (void) viewWillAppear:(BOOL)animated {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.addButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void) addPhrase: (NSString *) original
{
    if ([original isEqualToString: @""])
        return;

    Phrase *phrase = [[Phrase alloc] initWithOriginal: original meaning: @"There is no meaning to nothing"];
    [self insertToDataSource: phrase];
    [self insertRowAt: (self.phrases.count - 1)];

//    [self saveToDisk];
}

- (void)insertToDataSource: (Phrase *) phrase
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray: self.phrases];
    [mutableArray addObject: phrase];
    self.phrases = mutableArray;
}

- (void)insertRowAt: (int) index
{
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: [NSIndexPath indexPathForRow: index inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
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

- (void)setupData
{
    Phrase *phrase1 = [[Phrase alloc] initWithOriginal: @"clean" meaning: @"There is no meaning to nothing"];
    Phrase *phrase2 = [[Phrase alloc] initWithOriginal: @"dirty" meaning: @"There is no meaning to nothing"];
    self.phrases = [NSArray arrayWithObjects: phrase1, phrase2, nil];
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
//        [self saveToDisk];
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
