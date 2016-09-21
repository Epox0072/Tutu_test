//
//  DataCities.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCities : NSObject

@property (strong, nonatomic) NSMutableArray *citiesFrom;
@property (strong, nonatomic) NSMutableArray *citiesTo;


@property (strong, nonatomic) NSMutableArray *citiesFromSections;
@property (strong, nonatomic) NSMutableArray *citiesToSections;


- (void)createSections;


@end
