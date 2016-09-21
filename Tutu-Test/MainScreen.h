//
//  ViewController.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCities.h"
#import "Station.h"

@interface MainScreen : UIViewController

@property (strong, nonatomic) DataCities *dataCities;
@property (strong, nonatomic) Station *stationFrom;
@property (strong, nonatomic) Station *stationTo;
@property (strong, nonatomic) NSDate *selectedDate;

@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *btn_accept_date;

@property (weak, nonatomic) IBOutlet UIButton *btn_from;
@property (weak, nonatomic) IBOutlet UIButton *btn_to;
@property (weak, nonatomic) IBOutlet UIButton *btn_date;
@property (weak, nonatomic) IBOutlet UIButton *btn_show_schedule;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blur_view;

- (IBAction)btnFromTapped:(id)sender;
- (IBAction)btnToTapped:(id)sender;
- (IBAction)btnDateTapped:(id)sender;
- (IBAction)aboutAppTapped:(id)sender;
- (IBAction)showScheduleTapped:(id)sender;
- (IBAction)acceptDateTapped:(id)sender;

// recieve data from table with stations
- (void)sendStation:(Station *)station segueID:(NSString *)segueID;

@end

