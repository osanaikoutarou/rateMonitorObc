//
//  WebAPIRequest.m
//  MyBestHouse
//
//  Created by 長内幸太郎 on 2016/01/26.
//  Copyright © 2016年 osanaikoutarou. All rights reserved.
//

#import "WebAPIRequest.h"
//#import "ApiKey.h"

#define LOG_V(A, ...) if(NO) NSLog(@"%@",[NSString stringWithFormat:A, ## __VA_ARGS__]);

@implementation WebAPIRequest

+ (void)serverRequestWithPath:(NSString *)path
                        param:(NSDictionary*)parameterData
                       method:(NSString *)method
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock {
    
    NSString *baseUrl = path;//[NSString stringWithFormat:@"%@/%@/%@/%@",BASE_WEB_URL,API_PATH_PREFIX,API_VERSION,path];
    
    if ([method isEqualToString:HTTP_METHOD_GET]) {
        baseUrl = [self addParam:baseUrl param:parameterData];
    }
    
    //    [TLBWebAPIRequest setCookie];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    // request
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //TODO:タイムアウト
    sessionManager.requestSerializer.timeoutInterval = 13.0f;
    
    //TODO:if need
    // header
//     [self setHeader:requestOperationManager];
    [self setHeader:sessionManager];
    
    // response
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // ログ
    //TODO: LOG_Vにする
    LOG(@"========== API Request Begin in WebAPI ==========\n");
    LOG(@"==== medhot:%@  url:%@ ",method,baseUrl);
    
    // 共通blockの定義（※APIを投げた後のblock）
    void (^successCommonOperationBlock)(NSURLSessionDataTask*, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        // ログ
        [self showLog:YES url:baseUrl sessionManager:sessionManager task:task responseObject:responseObject error:nil];
        // 共通処理
        [self afterSuccessWithTask:task responseObject:responseObject];
        // 個別処理
        successBlock(task,responseObject);
    };
    void (^failureCommonOperationBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        // ログ
        [self showLog:NO url:baseUrl sessionManager:sessionManager task:task responseObject:nil error:error];
        // 共通処理
        [self afterFailureWithTask:task error:error];
        // 個別処理
        failureBlock(task,error);
    };
    
    // APIリクエスト,RESTによる振り分け,返ってきた後の共通処理blockは上記blockに定義
    if ([method isEqualToString:HTTP_METHOD_GET]) {
        [sessionManager GET:baseUrl
                 parameters:nil
                   progress:nil
                    success:successCommonOperationBlock
                    failure:failureCommonOperationBlock];
//        [sessionManager GET:baseUrl parameters:nil success:successCommonOperationBlock failure:failureCommonOperationBlock];
    }
    if ([method  isEqualToString:HTTP_METHOD_POST]) {
//        [sessionManager POST:baseUrl parameters:parameterData success:successCommonOperationBlock failure:failureCommonOperationBlock];
    }
    if ([method  isEqualToString:HTTP_METHOD_PATCH]) {
        [sessionManager PATCH:baseUrl parameters:parameterData success:successCommonOperationBlock failure:failureCommonOperationBlock];        
    }
    if ([method  isEqualToString:HTTP_METHOD_DELETE]) {
        [sessionManager DELETE:baseUrl parameters:parameterData success:successCommonOperationBlock failure:failureCommonOperationBlock];
    }
}

+ (NSString *)addParam:(NSString *)baseUrl param:(NSDictionary *)dictionary {
    if (!dictionary) {
        return baseUrl;
    }
    
    NSMutableString *prams = [[NSMutableString alloc] init];
    for (id key in dictionary) {
        if ([[dictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
            // paramが配列
            NSArray *array = [dictionary objectForKey:key];
            for (NSString *objStr in array) {
                [prams appendFormat:@"%@[]=%@&",key,objStr];
            }
        }
        else {
            [prams appendFormat:@"%@=%@&",key,[dictionary objectForKey:key]];
        }
    }
    NSString *removeLastChar = [prams substringWithRange:NSMakeRange(0, [prams length]-1)];
    return [NSString stringWithFormat:@"%@?%@",baseUrl,removeLastChar];
}

#pragma mark - header

+ (void)setHeader:(AFHTTPSessionManager *)sessionManager {
    
//    ApiKey *apiKey = [ApiKey MR_findFirst];
//    if (!apiKey) {
//        //TODO:対策
//        [sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Access-Token"];
//    }
//    else {
//        NSString *accessToken = apiKey.access_token;
//        [sessionManager.requestSerializer setValue:accessToken
//                                forHTTPHeaderField:@"Access-Token"];
//    }
}

#pragma mark - 共通処理

+ (void)afterSuccessWithTask:(NSURLSessionDataTask *)task
              responseObject:(id)responseObject {
    
    LOG_V(@"---通信成功後、共通処理---");
}

+ (NSError *)afterFailureWithTask:(NSURLSessionDataTask *)task
                            error:(NSError *)error {
    
    LOG_V(@"---通信失敗後、共通処理---");
    LOG_V(@"url:%@",task.response.URL.absoluteString);
    
    //TODO:customNSError サーバと仕様相談
    NSString *response = [error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
    NSData *responseBytes = [response dataUsingEncoding:NSUTF8StringEncoding];
    id json = nil;
    if (responseBytes) {
        json = [NSJSONSerialization JSONObjectWithData:responseBytes options:NSJSONReadingMutableContainers error:nil];
    }
    
    NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
    
    [userInfo setObject:[NSNumber numberWithInteger:((NSHTTPURLResponse *)task.response).statusCode] forKey:@"status_code"];
    if (json) {
        [userInfo setObject:json forKey:@"response_json"];
    } else {
        [userInfo setObject:@"" forKey:@"response_json"];
    }
    
    NSError *customError= [NSError errorWithDomain:@"QuelonErrorDomain" code:0 userInfo:userInfo];
    
    return customError;
}

#pragma mark - ログ

//ログを表示する
+ (void)showLog:(BOOL)success
            url:(NSString *)url
 sessionManager:(AFHTTPSessionManager *)manager
           task:(NSURLSessionDataTask *)task
 responseObject:(id)responseObject
          error:(NSError *)error {
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    
    //TODO:LOG_Vにする
    LOG_V(@"========== ▽ API Responsed : %@ ▽ ==========",(success)?@"SUCCESS":@"FAILED");
    LOG_V(@"  [URL             ]: %@",url);
    LOG_V(@"  [HTTP Status Code]: %ld", response.statusCode);
    LOG_V(@"  [Req Header      ]: \n%@", manager.requestSerializer.HTTPRequestHeaders);
    LOG_V(@"  [Res Header      ]: \n%@", response.allHeaderFields);
    //    LOG_V(@"  [Res Body        ]: \n%@", (responseObject)?responseObject:@"null");
    
    if (!success) {
        NSString *response = [((NSError *) responseObject).userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        NSData *responseBytes = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = nil;
        if (responseBytes) {
            json = [NSJSONSerialization JSONObjectWithData:responseBytes options:NSJSONReadingMutableContainers error:nil];
        }
        //TODO:LOG_Eにする
        LOG(@"  [Error Body      ]: \n%@", error);
        LOG(@"  [Response JSON   ]: \n%@", json);
        
        // 400系エラー log
        NSError *operationError = error;
        if(operationError != nil) {
            //TODO:正しいか？
            NSData * data = [operationError.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            if(data!=nil){
                NSString * converted =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //TODO:LOG_Eにする
                LOG(@"[response.error.data]:%@", converted);
            }
        }
    }
    
    //TODO:LOG_Vにする
    LOG_V(@"========== ▲ API Response End ▲ ==========");
}

// JSONオブジェクトをNSStringに変換する
+ (NSString *)convertToStringFromJsonDictinary:(NSDictionary *)jsonDictionary {
    NSString *result = @"JSON parse error";
    if([NSJSONSerialization isValidJSONObject:jsonDictionary]){
        NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return result;
}


@end
