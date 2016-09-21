//
//  AboutAppViewController.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 14/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "AboutAppVC.h"
#import "Helper.h"

@interface AboutApp ()

@end

@implementation AboutApp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *appName = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
    NSString *version = [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];

    [self.aboutView setAttributedText:[Helper create_text_attr_from_arr:@[@"Created by:",
                                                                          @"Stanislav Gaponov",
                                                                          @"Application:",
                                                                          appName,
                                                                          @"Version app:",
                                                                          version]]];
                                       
    // Do any additional setup after loading the view.
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
