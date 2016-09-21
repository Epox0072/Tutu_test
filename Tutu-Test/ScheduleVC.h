//
//  ScheduleVC.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 18/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *infoTV;

@property (nonatomic, strong) NSArray *scheduleInfo;

@end
