//
//  DataBuilder.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 11/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "Station.h"
#import "DataCities.h"

@interface DataBuilder : NSObject

/// создает наш итоговый объект с данными
+ (DataCities *)buildDataFromJSON:(NSData *)jsonData error:(NSError **)error;
/// возвращает массив с объектами City созданные из массива городов взятого из JSON
+ (NSMutableArray *)buildCities:(NSArray *)citiesRaw;
/// возвращает массив с объектами Station созданные из массива станций взятого из JSON
+ (NSMutableArray *)buildStations:(NSArray *)stationsRaw;
/// возвращает объект Coordinate созданные из словаря взятого из JSON
+ (Coordinate *)buildCoordinate:(NSDictionary *)pointRaw;

@end
