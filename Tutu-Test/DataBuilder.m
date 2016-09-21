//
//  DataBuilder.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "DataBuilder.h"
#import "City.h"


@implementation DataBuilder

+ (DataCities *)buildDataFromJSON:(NSData *)jsonData error:(NSError *__autoreleasing *)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        NSLog(@"Error in json data");
        return nil;
    }
    
    DataCities *dataCities = [[DataCities alloc] init];
    for (NSString *key in parsedObject) {
        if ([dataCities respondsToSelector:NSSelectorFromString(key)]) {
            NSArray *cities = [DataBuilder buildCities:[parsedObject objectForKey:key]];
            [dataCities setValue:cities forKey:key];
        }
    }
    
    [dataCities createSections];
    
    return dataCities;
}

+ (NSMutableArray *)buildCities:(NSArray *)citiesRaw {
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    for (NSDictionary* cityRaw in citiesRaw) {
        City *city = [[City alloc] init];
        
        for (NSString *key in cityRaw) {
            if ([key isEqualToString:@"point"]) {
                Coordinate *coordinate = [DataBuilder buildCoordinate:[cityRaw objectForKey:key]];
                [city setValue:coordinate forKey:key];
                
            } else if ([key isEqualToString:@"stations"]) {
                NSArray *stations = [DataBuilder buildStations:[cityRaw objectForKey:key]];
                [city setValue:stations forKey:key];
                
            } else {
                if ([city respondsToSelector:NSSelectorFromString(key)]) {
                    [city setValue:[NSString stringWithFormat:@"%@", [cityRaw objectForKey:key]] forKey:key];
                }
            }
        }
        [cities addObject:city];
    }
    
    return cities;
}

+ (Coordinate *)buildCoordinate:(NSDictionary *)pointRaw {
    Coordinate *coordinate = [[Coordinate alloc] init];
    for (NSString *key in pointRaw) {
        if ([coordinate respondsToSelector:NSSelectorFromString(key)]) {
            [coordinate setValue:[pointRaw objectForKey:key] forKey:key];
        }
    }
    
    return coordinate;
}

+ (NSMutableArray *)buildStations:(NSArray *)stationsRaw {
    NSMutableArray *stations = [[NSMutableArray alloc] init];
    
    for (NSDictionary* stationRaw in stationsRaw) {
        Station *station = [[Station alloc] init];
        
        for (NSString *key in stationRaw) {
            if ([key isEqualToString:@"point"]) {
                Coordinate *coordinate = [DataBuilder buildCoordinate:[stationRaw objectForKey:key]];
                [station setValue:coordinate forKey:key];
            } else {
                if ([station respondsToSelector:NSSelectorFromString(key)]) {
                    [station setValue:[NSString stringWithFormat:@"%@", [stationRaw objectForKey:key]] forKey:key];
                }
            }
        }
        [stations addObject:station];
    }
    
    return stations;
}

@end
