//
//  ViewPhrasesViewController.m
//  Fresa
//
//  Created by Zi on 10/5/14.
//  Copyright (c) 2014 Zi. All rights reserved.
//

#import "ViewPhrasesViewController.h"
#import "Phrase.h"

@interface ViewPhrasesViewController ()

@property (strong) UITableView *tableView;
@property (copy) NSArray *phrases;

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
    
    self.title = @"Phrases";
    
    [self setupData];
    [self setupTableView];
}

- (void)setupData
{
    Phrase *phrase1 = [[Phrase alloc] init];
    phrase1.original = @"clean";
    Phrase *phrase2 = [[Phrase alloc] init];
    phrase2.original = @"dirty";
    
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
