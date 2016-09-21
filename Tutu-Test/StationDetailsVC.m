//
//  StationDetailsVC.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 15/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "StationDetailsVC.h"
#import "Protocols.h"
#import "Helper.h"

@interface StationDetailsVC ()

@end

@implementation StationDetailsVC

@synthesize send_back_delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // убирает отступ
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
    self.title = self.station.stationTitle;
    if (self.station) {
        if (self.station.stationTitle) {
            NSMutableAttributedString *description_s = [Helper create_text_attr_from_arr:@[@"Название:", self.station.stationTitle, @"\nПолный адрес:", [self get_full_adress_for_station]]];
            [self.stationInfo setAttributedText:description_s];
        }
    }
}

/// создать строку полного адреса
- (NSString *)get_full_adress_for_station {
    NSString *str = @"";
    if (self.station.countryTitle && ![self.station.countryTitle isEqualToString:@""]) {
        str = [str stringByAppendingString:self.station.countryTitle];
    }
    if (self.station.regionTitle && ![self.station.regionTitle isEqualToString:@""]) {
        if (str.length > 0) str = [str stringByAppendingString:@",\n"];
        str = [str stringByAppendingString:self.station.regionTitle];
    }
    if (self.station.cityTitle && ![self.station.cityTitle isEqualToString:@""]) {
        if (str.length > 0) str = [str stringByAppendingString:@",\n"];
        str = [str stringByAppendingString:self.station.cityTitle];
    }
    if (self.station.districtTitle && ![self.station.districtTitle isEqualToString:@""]) {
        if (str.length > 0) str = [str stringByAppendingString:@",\n"];
        str = [str stringByAppendingString:self.station.districtTitle];
    }
    
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)acceptStationTapped:(id)sender {
    [send_back_delegate sendStation:self.station segueID:self.segueID];
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
