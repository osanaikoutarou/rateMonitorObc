//
//  NSMutableArray+Utility.m
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/05/23.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import "NSMutableArray+Utility.h"

@implementation NSMutableArray (Utility)

- (BOOL)addObjectIfNotContain:(id)object {
	if(![self containsObject:object]) {
		[self addObject:object];
		return YES;
	}
	return NO;
}

@end
