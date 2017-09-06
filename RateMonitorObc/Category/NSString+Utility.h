//
//  NSString+Utility.h
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/05/23.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;
- (NSString *)add:(NSString *)str;
- (NSURL *)URL;

+ (BOOL)isEmpty:(NSString *)str;
+ (BOOL)isNotEmpty:(NSString *)str;

@end
