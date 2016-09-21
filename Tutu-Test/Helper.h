//
//  Helper.h
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 16/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

/// возвращает все свойства класса в виде словаря с указанием типов данных
+ (NSDictionary *)classPropsFor:(Class)сlass;

/// создает атрибутную строку из массива - четные элементы с шрифтом 21 и черные, не четные темные серые и 20
+ (NSMutableAttributedString *)create_text_attr_from_arr:(NSArray *)arr;

@end
