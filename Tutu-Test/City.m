//
//  City.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "City.h"
#import "Helper.h"

@implementation City

+ (City *)create_from_city:(City *)city withStations:(BOOL)with {
    City *city_n = [City new];
    // получим все доступные свойства класса
    NSDictionary* props = [Helper classPropsFor:[City class]];
    for (NSString* key in props.allKeys) {
        if (!with && [key isEqualToString:@"stations"]) continue;
        if ([city_n respondsToSelector:NSSelectorFromString(key)]) {
            [city_n setValue:[NSString stringWithFormat:@"%@", [city valueForKey:key]] forKey:key];
        }
    }
    return city_n;
}

@end
