//
//  ViewController.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "MainScreen.h"
#import "DataBuilder.h"
#import "StationsTVC.h"
#import "ScheduleVC.h"

#define ANIM_DURATION ((float) 0.3)

@interface MainScreen ()

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self load_json_data];
    
    // перенос в кнопках
    self.btn_from.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btn_to.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btn_date.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btn_show_schedule.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)viewWillAppear:(BOOL)animated {
    [self set_up_picker];
    [self applyDate];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)set_up_picker {
    [self.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    NSTimeInterval oneDay = 60*60*24;
    [self.datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:oneDay*365*2]];
}

- (void)load_json_data {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allStations" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (jsonData) {
        NSError *error;
        self.dataCities = [DataBuilder buildDataFromJSON:jsonData error:&error];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"From"]) {
        UINavigationController *nav_c = [segue destinationViewController];
        if ([nav_c viewControllers].count > 0) {
            StationsTVC *vc = [[nav_c viewControllers] objectAtIndex:0];
            [vc setCities:self.dataCities.citiesFrom];
            [vc setSegueID:@"From"];
            [vc setSectionTitles:self.dataCities.citiesFromSections];
            vc.send_back_delegate = self;
        }
        
    } else if ([[segue identifier] isEqualToString:@"To"]) {
        UINavigationController *nav_c = [segue destinationViewController];
        if ([nav_c viewControllers].count > 0) {
            StationsTVC *vc = [[nav_c viewControllers] objectAtIndex:0];
            [vc setCities:self.dataCities.citiesTo];
            [vc setSegueID:@"To"];
            [vc setSectionTitles:self.dataCities.citiesToSections];
            vc.send_back_delegate = self;
        }
    } else if ([[segue identifier] isEqualToString:@"show_schedule"]) {
        ScheduleVC *vc = [segue destinationViewController];
        NSArray *arr = @[@"Место отправления:",
                         [self createFullNameForStation:self.stationTo],
                         @"\nМесто прибытия:",
                         [self createFullNameForStation:self.stationFrom],
                         @"\nДата отправления:",
                         [self getDateByString]];
        [vc setScheduleInfo:arr];
    }
}

- (NSString *)createFullNameForStation:(Station *)station {
    return [NSString stringWithFormat:@"%@, %@, %@", station.countryTitle, station.cityTitle, station.stationTitle];
}

- (void)sendStation:(Station *)station segueID:(NSString *)segueID {
    if ([segueID isEqualToString:@"From"]) {
        if (station) {
            self.stationFrom = station;
            [self setText:self.stationFrom.stationTitle forButton:self.btn_from];
        }
    } else if ([segueID isEqualToString:@"To"]) {
        if (station) {
            self.stationTo = station;
            [self setText:self.stationTo.stationTitle forButton:self.btn_to];
        }
    }
    
    if (self.stationTo && self.stationFrom) {
        [self.btn_show_schedule setHidden:NO];
        [self.btn_show_schedule setEnabled:YES];
    }
}

- (void)setText:(NSString *)text forButton:(UIButton *)btn {
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateHighlighted];
    [btn setTitle:text forState:UIControlStateDisabled];
    [btn setTitle:text forState:UIControlStateSelected];
}

- (IBAction)btnFromTapped:(id)sender {}

- (IBAction)btnToTapped:(id)sender {}

- (IBAction)btnDateTapped:(id)sender {
    [self showPicker];
}

- (void)showPicker {
    [self.datePickerView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + self.datePickerView.frame.size.height/2 + 20)];
    [self.datePickerView setHidden:NO];
    
    self.blur_view.effect = nil;
    [self.blur_view setHidden:NO];
    [UIView animateWithDuration:ANIM_DURATION animations:^{
        self.blur_view.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        [self.datePickerView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - self.datePickerView.frame.size.height/2 - 20)];
    } completion:^(BOOL finished) {
        [self.datePicker setEnabled:YES];
    }];
}

-(void)hidePicker {
    [self.datePicker setEnabled:NO];
    [UIView animateWithDuration:ANIM_DURATION animations:^{
        self.blur_view.effect = nil;
        [self.datePickerView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + self.datePickerView.frame.size.height/2 + 20)];
    } completion:^(BOOL finished) {
        [self.datePickerView setHidden:YES];
        [self applyDate];
        [self.blur_view setHidden:YES];
        
    }];
}

- (IBAction)aboutAppTapped:(id)sender {}

- (IBAction)showScheduleTapped:(id)sender {}

- (void)applyDate {
    self.selectedDate = [self.datePicker date];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.selectedDate
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    [self setText:dateString forButton:self.btn_date];
}

- (NSString *)getDateByString {
    return [NSDateFormatter localizedStringFromDate:self.selectedDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

- (IBAction)acceptDateTapped:(id)sender {
    [self hidePicker];
}

@end
