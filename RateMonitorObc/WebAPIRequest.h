//
//  WebAPIRequest.h
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/01/26.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#define LOG(A, ...) if(NO) NSLog(@"LOG: %s:%d:%@", __PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:A, ## __VA_ARGS__]);

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
//#import "AFHTTPRequestOperationManager.h"

#define HTTP_METHOD_GET         @"GET"
#define HTTP_METHOD_POST        @"POST"
#define HTTP_METHOD_PATCH       @"PATCH"
#define HTTP_METHOD_DELETE      @"DELETE"

@interface WebAPIRequest : NSObject

+ (void)serverRequestWithPath:(NSString *)path
                        param:(NSDictionary*)parameterData
                       method:(NSString *)method
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock;

@end
