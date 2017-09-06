//
//  NSArray+helper.m
//  MyBestHouse
//
//  Created by osanaikoutarou on 2015/04/09.
//  Copyright (c) 2015年 osanaikoutarou. All rights reserved.
//

#import "NSArray+helper.h"

@implementation NSArray (helper)

- (CGSize)cgsizeAtIndex:(NSUInteger)index {
    //valueで入っていること
    NSValue *value = [self objectAtIndex:index];
    return value.CGSizeValue;
}


- (CGRect)cgrectAtIndex:(NSUInteger)index {
    //valueで入っていること
    NSValue *value = [self objectAtIndex:index];
    return value.CGRectValue;
}

+ (id)objectAtIndexSafe:(NSUInteger)index inArray:(NSArray *)array {
    if (array == nil) {
        return nil;
    }
    if (array.count <= index) {
        return nil;
    }
    
    return array[index];
}

@end
