//
//  NSArray+NSArray_helper.h
//  MyBestHouse
//
//  Created by osanaikoutarou on 2015/04/09.
//  Copyright (c) 2015年 osanaikoutarou. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
@interface NSArray (helper)

- (CGSize)cgsizeAtIndex:(NSUInteger)index;

- (CGRect)cgrectAtIndex:(NSUInteger)index;

+ (id)objectAtIndexSafe:(NSUInteger)index inArray:(NSArray *)array;

@end
