//
//  NSMutableArray+helper.h
//  MyBestHouse
//
//  Created by osanaikoutarou on 2015/04/09.
//  Copyright (c) 2015年 osanaikoutarou. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@interface NSMutableArray (helper)


- (void)addCGSizeFormValue:(CGSize)size;
- (CGSize)cgsizeAtIndex:(NSUInteger)index;

- (void)addCGRectFormValue:(CGRect)rect;
- (CGRect)cgrectAtIndex:(NSUInteger)index;
@end
