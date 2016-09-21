//
//  DataCities.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "DataCities.h"
#import "City.h"

@implementation DataCities

- (void)createSections {
    if (self.citiesTo) {
        self.citiesToSections = [self sectionTitlesFor:self.citiesTo];
    }
    if (self.citiesFrom) {
        self.citiesFromSections = [self sectionTitlesFor:self.citiesFrom];
    }
}

- (NSMutableArray *)sectionTitlesFor:(NSMutableArray *)cities {
    NSMutableArray *sectionTitles = [NSMutableArray new];
    for (City* city in cities) {
        NSString* title = [NSString stringWithFormat:@"%@, %@", city.countryTitle, city.cityTitle];
        [sectionTitles addObject:title];
    }
    return sectionTitles;
}

@end
