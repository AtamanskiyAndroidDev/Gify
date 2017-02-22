//
//  KPMain.h
//  Kinopoisk
//
//  Created by sasha ataman on 13.02.17.
//  Copyright © 2017 sasha ataman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIFSegmentedControl.h"

@interface GIFMain : UIViewController<UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIToolbarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)fetchNextRandomGif:(id)sender;

@end
