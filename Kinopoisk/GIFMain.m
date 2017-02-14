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

@interface GIFMain ()

@end

@implementation GIFMain
{
    UISearchController *searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchController];
    GIFNetworkManager *manager = [GIFNetworkManager sharedInstance];
    [manager fetchTrending];
    // Do any additional setup after loading the view.
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GIFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    for (NSIndexPath *indexVisible in tableView.indexPathsForVisibleRows) {
        CGRect cellRect = [tableView rectForRowAtIndexPath:indexVisible];
        BOOL isVisible = CGRectContainsRect(tableView.bounds, cellRect);
        if (isVisible) {
 //           [cell setupCell:array[indexPath.row]];
            NSLog(@"%@", [NSString stringWithFormat:@"%ld",(long)indexVisible.row]);
        } else {
            [cell stopAnimated];
        }
    }
    
    return cell;
}

@end
