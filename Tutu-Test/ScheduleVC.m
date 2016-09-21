//
//  ScheduleVC.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 18/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "ScheduleVC.h"
#import "Helper.h"

@interface ScheduleVC ()

@end

@implementation ScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // убирает отступ
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.scheduleInfo) {
        [self.infoTV setAttributedText:[Helper create_text_attr_from_arr:self.scheduleInfo]];
    }
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

@end
