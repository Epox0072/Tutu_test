//
//  Helper.m
//  Tutu-Test
//
//  Created by Станилсав Гапонов on 16/09/16.
//  Copyright © 2016 Stanislav Gaponov. All rights reserved.
//

#import "Helper.h"
#import "objc/runtime.h"
#import <UIKit/UIKit.h>

@implementation Helper

static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}


+ (NSDictionary *)classPropsFor:(Class)class
{
    if (class == NULL) {
        return nil;
    }
    
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [results setObject:propertyType forKey:propertyName];
        }
    }
    free(properties);
    
    // returning a copy here to make sure the dictionary is immutable
    return [NSDictionary dictionaryWithDictionary:results];
}








+ (NSMutableAttributedString *)create_text_attr_from_arr:(NSArray *)arr {
    NSString *str_full = @"";
    for (NSString *str in arr) {
        str_full = [str_full stringByAppendingString:str];
        str_full = [str_full stringByAppendingString:@"\n"];
    }
    
    NSMutableAttributedString *stringText = [[NSMutableAttributedString alloc] initWithString:str_full];
    
    NSRange range;
    for (int i = 0; i < arr.count; i++) {
        NSString *str = [arr objectAtIndex:i];
        if (i == 0) {
            range = NSMakeRange(0, str.length);
        } else {
            range = NSMakeRange(range.location + range.length + 1, str.length);
        }
        if (i % 2 == 0) {
            [stringText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:21.] range:range];
            [stringText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        } else {
            [stringText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:20.] range:range];
            [stringText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
        }
    }
    
    return stringText;
}

@end
