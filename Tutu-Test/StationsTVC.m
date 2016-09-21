//
//  StationsFromTVC.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 14/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "StationsTVC.h"
#import "City.h"
#import "StationDetailsVC.h"
#import "Protocols.h"

@interface StationsTVC ()

@end

@implementation StationsTVC

@synthesize send_back_delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self initSearch];
    [self.accept_bar_btn setEnabled:NO];
}

- (void)initSearch {
    self.resultSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.resultSearchController.searchResultsUpdater = self;
    self.resultSearchController.hidesNavigationBarDuringPresentation = NO;
    self.resultSearchController.dimsBackgroundDuringPresentation = NO;
    self.resultSearchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
    [self.resultSearchController.searchBar sizeToFit];
    self.resultSearchController.searchBar.scopeButtonTitles = @[];
    self.tableView.tableHeaderView = self.resultSearchController.searchBar;
    self.definesPresentationContext = YES;
    [self.resultSearchController loadViewIfNeeded];
    self.resultSearchController.delegate = self;
    self.resultSearchController.searchBar.delegate = self;
}

- (void) dismissKeyboard
{
    [self.resultSearchController.searchBar resignFirstResponder];
}


- (IBAction)acceptSelectedStansion:(id)sender {
    // hide keyboard
    [self.resultSearchController.searchBar resignFirstResponder];
    [send_back_delegate sendStation:self.station_selected segueID:self.segueID];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelStationSelection:(id)sender {
    // hide keyboard
    [self.resultSearchController.searchBar resignFirstResponder];
    
    self.station_selected = nil;
    [send_back_delegate sendStation:self.station_selected segueID:self.segueID];
    
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultSearchController.active) {
        return self.searchResults.count;
    } else {
        return self.cities.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.resultSearchController.active) {
        City* city = [self.searchResults objectAtIndex:section];
        return city.stations.count;
    } else {
        City* city = [self.cities objectAtIndex:section];
        return city.stations.count;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.resultSearchController.active) {
        City* city = [self.searchResults objectAtIndex:section];
        NSString* title = [NSString stringWithFormat:@"%@, %@", city.countryTitle, city.cityTitle];
        return title;
    } else {
        return [self.sectionTitles objectAtIndex:section];
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationsCell" forIndexPath:indexPath];
    if (self.resultSearchController.active) {
        City* city = [self.searchResults objectAtIndex:indexPath.section];
        Station* station = [city.stations objectAtIndex:indexPath.row];
        cell.textLabel.text = station.stationTitle;
    } else {
        City* city = [self.cities objectAtIndex:indexPath.section];
        Station* station = [city.stations objectAtIndex:indexPath.row];
        cell.textLabel.text = station.stationTitle;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.resultSearchController.active) {
        self.selected_index = [self apply_did_select_row:indexPath specific_index_path:self.selected_index];
        [self dismissKeyboard];
    } else {
        self.selected_index = [self apply_did_select_row:indexPath specific_index_path:self.selected_index];
    }
}

// apply select cell for index path and resume index for changing global
- (NSIndexPath *)apply_did_select_row:(NSIndexPath *)indexPath specific_index_path:(NSIndexPath *)spec {
    if (spec) {
        if (spec.section == indexPath.section && spec.row == indexPath.row) {
            // if same
            spec = [self resetSelectionForIndexPath:spec];
            [self.accept_bar_btn setEnabled:NO];
        } else {
            // another
            [self resetSelectionForIndexPath:spec];
            spec = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [self selectStationByIndexPath:indexPath];
            [self.accept_bar_btn setEnabled:YES];
        }
    } else {
        // new selection
        spec = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [self selectStationByIndexPath:indexPath];
        [self.accept_bar_btn setEnabled:YES];
    }
    
    return spec;
}

// reselect cell for index path and resume index for changing global
- (NSIndexPath *)resetSelectionForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        self.station_selected = NULL;
        indexPath = NULL;
    }
    
    return indexPath;
}

// определяем - ячейка на экране?
- (BOOL)cell_is_on_screen:(NSIndexPath *)indexPath {
    NSArray *arr = [self.tableView visibleCells];
    float y = [[self.tableView cellForRowAtIndexPath:indexPath] frame].origin.y;
    if (arr && arr.count > 0) {
        if (y > [[arr objectAtIndex:0] frame].origin.y && y < [[arr lastObject] frame].origin.y + [[arr lastObject] frame].size.height) {
            return YES;
        }
    }
    return NO;
}

// выбрали сатанцию по индексу
- (void)selectStationByIndexPath:(NSIndexPath *)indexPath {
    self.station_selected = [self getStationByIndexPath:indexPath];
}

// получаем станцию по IndexPath
- (Station *)getStationByIndexPath:(NSIndexPath *)indexPath {
    if (self.resultSearchController.active) {
        City *city = [self.searchResults objectAtIndex:indexPath.section];
        return [city.stations objectAtIndex:indexPath.row];
    } else {
        City *city = [self.cities objectAtIndex:indexPath.section];
        return [city.stations objectAtIndex:indexPath.row];
    }
    
    return nil;
}

#pragma mark - SEARCH

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length > 0) {
        [self.searchResults removeAllObjects];
        
        self.searchResults = [self search_by_text:searchController.searchBar.text];
        [self.tableView reloadData ];
        
    } else {
        // с этим моментом внимательно.
        [self.searchResults removeAllObjects];
        ////
        self.searchResults = [[NSMutableArray alloc] initWithArray:self.cities];
        [self.tableView reloadData];
    }
}

- (NSMutableArray *)search_by_text:(NSString *)text {
    // поиск по части имени (как начальной, так и входящей, не зависимо от регистра)
    NSMutableArray *arr = [NSMutableArray new];
    for (City *city in self.cities) {
        NSString* filter = @"%K BEGINSWITH[cd] %@ || %K CONTAINS[cd] %@";
        NSArray* args = @[@"stationTitle", text, @"stationTitle", text];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter argumentArray:args];
        NSArray *filtered = [city.stations filteredArrayUsingPredicate:predicate];
        if (filtered.count > 0) {
            City *city_n = [City create_from_city:city withStations:NO];
            city_n.stations = [NSMutableArray arrayWithArray:filtered];
            [arr addObject:city_n];
        }
    }
    
    return arr;
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    self.selected_index = [self resetSelectionForIndexPath:self.selected_index];
    [self.accept_bar_btn setEnabled:NO];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"DISMISSED");
    self.selected_index = [self resetSelectionForIndexPath:self.selected_index];
    [self.accept_bar_btn setEnabled:NO];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"station_details"]) {
        StationDetailsVC *vc = [segue destinationViewController];
        // pre-accept station
        [vc setStation:[self getStationByIndexPath:[self.tableView indexPathForCell:sender]]];
        [vc setSegueID:self.segueID];
        [vc setSend_back_delegate:send_back_delegate];
    }
}

@end
