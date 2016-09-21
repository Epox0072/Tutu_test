//
//  Station.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Station : NSObject

@property (strong, nonatomic) NSString *countryTitle;
@property (strong, nonatomic) NSString *districtTitle;
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *cityTitle;
@property (strong, nonatomic) NSString *regionTitle;
@property (strong, nonatomic) NSString *stationId;
@property (strong, nonatomic) NSString *stationTitle;
@property (strong, nonatomic) Coordinate *point;

@end
