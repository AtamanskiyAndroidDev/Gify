//
//  KPMain.m
//  Kinopoisk
//
//  Created by sasha ataman on 13.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import "GIFMain.h"
#import "GIFCell.h"
#import "GIFNetworkManager.h"
#import "GIFRealmDataManager.h"

@interface GIFMain ()

@end

@implementation GIFMain
{
    GIFNetworkManager *manager;
    UISearchController *search;
    GIFRealmDataManager *dataManager;
    RLMNotificationToken *notificationToken;
    GIFSegmentedControl *segmentControl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSearchController];
    manager = [GIFNetworkManager sharedInstance];
    [manager fetchTrending];
    dataManager =  [[GIFRealmDataManager alloc] init];
    __weak typeof(self) weakSelf = self;
    notificationToken = [dataManager.realm addNotificationBlock:^(RLMNotification notification, RLMRealm *realm){
        [weakSelf.tableView reloadData];
    }];
    [self addSegmentControllInNavigationBar];
    // Do any additional setup after loading the view.
}

-(void)dealloc
{
    [notificationToken stop];
}

-(void)addSegmentControllInNavigationBar
{
    NSArray *arr = [NSArray arrayWithObjects: @"Trending", @"Random", @"Search", nil];
    segmentControl = [[GIFSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    segmentControl.items = arr;
    segmentControl.selectedIndex = 0;
    NSLog(@"%li", segmentControl.selectedIndex);
    [segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentControl;
    
}


- (void)segmentValueChanged:(id *)sender
{
    switch (segmentControl.selectedIndex) {
        case 0:
        {
            [self hiddenHeaderView];
            [manager fetchTrending];
        }
            break;
        case 1:
        {
            [self hiddenHeaderView];
            [manager fetchRandom];
        }
            break;
        case 2:
        {
            [dataManager deleteAll];
            [self showHeaderView];
        }
            break;
    }
}

- (void)showHeaderView
{
    [_tableView.tableHeaderView setHidden:NO];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_tableView setContentOffset:(CGPointMake(0, 0)) animated:YES];
}

- (void)hiddenHeaderView
{
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.contentInset = UIEdgeInsetsMake(-search.searchBar.frame.size.height, 0, 0, 0);
    }completion:^(BOOL finished){
        if (finished && _tableView.contentInset.top == -search.searchBar.frame.size.height) {
            [_tableView.tableHeaderView setHidden:YES];
        }
    }];
}

- (void)fetchNextRandomGif:(id)sender
{
    [manager fetchRandom];
}

- (void)filterContentForSearchText:(NSString *)searchText
{
    NSLog(@"%@", searchText);
}

- (void)setupSearchController
{
    search = [[UISearchController alloc] initWithSearchResultsController:NULL];
    search.searchResultsUpdater = self;
    search.searchBar.delegate = self;
    search.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    _tableView.tableHeaderView = search.searchBar;
    [self hiddenHeaderView];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"%@", searchController.searchBar.text);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![searchBar.text  isEqual: @""]) {
        [manager fetchSearch:searchBar.text];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataManager.getAll count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GIFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setupCell:[dataManager getModel:indexPath.row]];
    return cell;
}

@end
