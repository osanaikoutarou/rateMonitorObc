//
//  WebAPI.m
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/01/26.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import "WebAPI.h"

@implementation WebAPI

// リクエスト共通部
+ (void)requestWithPath:(NSString *)path
                  param:(NSDictionary *)parameterData
                 method:(NSString *)method
             completion:(void (^)(BOOL success,id results, NSError *error, NSInteger statusCode))completionBlock {
    
    [WebAPIRequest serverRequestWithPath:path
                                   param:parameterData
                                  method:method
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     //TODO:共有処理 if need
                                     
                                     NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
                                     completionBlock(YES,responseObject,nil,statusCode);
                                     
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     //TODO:共有処理 if need
                                     
                                     NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
                                     completionBlock(NO,nil,error,statusCode);
                                 }];
}


@end
