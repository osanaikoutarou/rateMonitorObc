//
//  NSString+Utility.m
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/05/23.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (BOOL)isEmpty {
	if (self.length==0) {
		return YES;
	}
	return NO;
}

- (BOOL)isNotEmpty {
	if (self.length==0) {
		return NO;
	}
	return YES;
}

+ (BOOL)isEmpty:(NSString *)s {
    if (!s) {
        return YES;
    }
    if (s.length==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNotEmpty:(NSString *)s {
    if (s && s.length>0) {
        return YES;
    }
    return NO;
}


- (NSString *)add:(NSString *)str {
	return [self stringByAppendingString:str];
}

- (NSURL *)URL {
    return [NSURL URLWithString:self];
}

@end
