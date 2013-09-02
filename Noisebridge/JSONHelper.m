//
//  JSONHelper.m
//  FinalProject
//
//  Created by Ryan Brenner on 5/16/13.
//  Copyright (c) 2013 AugustRyanBrenner. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+(NSString*)jsonStringFromArray:(NSArray*)array
{
    NSArray *inputtedArray = [NSArray arrayWithArray:array];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:inputtedArray
                                                                options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end
