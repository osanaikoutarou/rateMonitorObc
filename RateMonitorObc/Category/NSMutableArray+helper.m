////
////  NSMutableArray+helper.m
////  MyBestHouse
////
////  Created by osanaikoutarou on 2015/04/09.
////  Copyright (c) 2015年 osanaikoutarou. All rights reserved.
////
//
//#import "NSMutableArray+helper.h"
//
//@implementation NSMutableArray (helper)
//
//#pragma mark - CGSize
//
//- (void)addCGSizeFormValue:(CGSize)size {
//    [self addObject:[NSValue valueWithCGSize:size]];
//}
//
//- (CGSize)cgsizeAtIndex:(NSUInteger)index {
//    //valueで入っていること
//    NSValue *value = [self objectAtIndex:index];
//    return value.CGSizeValue;
//}
//
//#pragma mark - CGRect
//
//- (void)addCGRectFormValue:(CGRect)rect {
//    [self addObject:[NSValue valueWithCGRect:rect]];
//}
//
//- (CGRect)cgrectAtIndex:(NSUInteger)index {
//    //valueで入っていること
//    NSValue *value = [self objectAtIndex:index];
//    return value.CGRectValue;
//}
//
//
//@end
