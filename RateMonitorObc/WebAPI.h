//
//  WebAPI.h
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/01/26.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebAPIRequest.h"
#import "NSString+Utility.h"
//#import "WebAPIParamModel.h"

@interface WebAPI : NSObject

+ (void)requestWithPath:(NSString *)path
                  param:(NSDictionary *)parameterData
                 method:(NSString *)method
             completion:(void (^)(BOOL success,id results, NSError *error, NSInteger statusCode))completionBlock;


@end
