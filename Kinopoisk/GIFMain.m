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
    UISearchController *searchController;
    GIFRealmDataManager *dataManager;
    RLMNotificationToken *notificationToken;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSearchController];
    GIFNetworkManager *manager = [GIFNetworkManager sharedInstance];
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
    NSArray *arr = [NSArray arrayWithObjects: @"Trending", @"Search", @"Random", nil];
    //UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems: arr];
    _segmentControl.items = arr;
    _segmentControl.selectedIndex = 2;
    NSLog(@"%li", _segmentControl.selectedIndex);
     [_segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    //self.navigationItem.titleView = _segmentControl;
    
}


- (void)segmentValueChanged:(id *)sender
{
    NSLog(@"%@", _segmentControl.selectedLabelColor);
}


- (void)filterContentForSearchText:(NSString *)searchText
{
    NSLog(@"%@", searchText);
}

- (void)setupSearchController
{
    searchController = [[UISearchController alloc] initWithSearchResultsController:NULL];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    _tableView.tableHeaderView = searchController.searchBar;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // do something from this text
  //  [self filterContentForSearchText:searchController.searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self updateSearchResultsForSearchController: self->searchController];
    NSLog(@"%@", searchBar.text);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataManager.getAll count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GIFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setupCell:[dataManager getModel:indexPath.row]];
    return cell;
}

@end
