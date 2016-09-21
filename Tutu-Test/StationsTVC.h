//
//  StationsFromTVC.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 14/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"

@interface StationsTVC : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *accept_bar_btn;
@property (nonatomic, assign) id send_back_delegate;
@property (nonatomic, strong) Station *station_selected;

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, strong) NSString *segueID;
@property (nonatomic, strong) NSMutableArray *sectionTitles;

@property (nonatomic, strong) NSIndexPath *selected_index;


@property (nonatomic, strong) UISearchController *resultSearchController;
@property (nonatomic, strong) NSMutableArray *searchResults;


- (IBAction)acceptSelectedStansion:(id)sender;
- (IBAction)cancelStationSelection:(id)sender;

@end
