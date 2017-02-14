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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchController];
    GIFNetworkManager *manager = [GIFNetworkManager sharedInstance];
    [manager fetchTrending];
    dataManager =  [[GIFRealmDataManager alloc] init];
    __weak typeof(self) weakSelf = self;
    notificationToken = [dataManager.realm addNotificationBlock:^(RLMNotification notification, RLMRealm *realm){
        [weakSelf.tableView reloadData];
    }];
//    notificationToken = [[dataManager getAll] addNotificationBlock:^(RLMResults<GIFModel *> *results, RLMCollectionChange *changes, NSError *error){
//        if (error) {
//            NSLog(@"Failed to open Realm on background worker: %@", error);
//            return;
//        }
//        
//        UITableView *tableView = weakSelf.tableView;
//        // Initial run of the query will pass nil for the change information
//        if (!changes) {
//            [tableView reloadData];
//            return;
//        }
//        
//        // Query results have changed, so apply them to the UITableView
//        [tableView beginUpdates];
//        [tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0]
//                         withRowAnimation:UITableViewRowAnimationAutomatic];
//        [tableView insertRowsAtIndexPaths:[changes insertionsInSection:0]
//                         withRowAnimation:UITableViewRowAnimationAutomatic];
//        [tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0]
//                         withRowAnimation:UITableViewRowAnimationAutomatic];
//        [tableView endUpdates];
//    }];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [notificationToken stop];
}

- (void)filterContentForSearchText: (NSString*) searchText{
    NSLog(@"%@", searchText);
}

- (void)setupSearchController {
    searchController = [[UISearchController alloc] initWithSearchResultsController:NULL];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    _tableView.tableHeaderView = searchController.searchBar;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    // do something from this text
  //  [self filterContentForSearchText:searchController.searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self updateSearchResultsForSearchController: self->searchController];
    NSLog(@"%@", searchBar.text);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataManager.getAll count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GIFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    for (NSIndexPath *indexVisible in tableView.indexPathsForVisibleRows) {
        CGRect cellRect = [tableView rectForRowAtIndexPath:indexVisible];
        BOOL isVisible = CGRectContainsRect(tableView.bounds, cellRect);
        if (isVisible) {
            [cell setupCell:[dataManager getModel:indexPath.row]];
            NSLog(@"%@", [NSString stringWithFormat:@"%ld",(long)indexVisible.row]);
        } else {
            [cell stopAnimated];
        }
    }
    
    return cell;
}

@end
