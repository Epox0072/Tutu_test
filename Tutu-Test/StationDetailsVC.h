//
//  StationDetailsVC.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 15/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"

@interface StationDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *stationInfo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_accept_station;


@property (nonatomic, strong) Station *station;
@property (nonatomic, assign) id send_back_delegate;
@property (nonatomic, strong) NSString *segueID;

- (IBAction)acceptStationTapped:(id)sender;

@end
