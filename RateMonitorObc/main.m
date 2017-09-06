//
//  main.m
//  RateMonitorObc
//
//  Created by osanai on 2017/09/04.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebAPI.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!a");
        
        double __block prevRate = 100;
        double __block currentRate = 100;
        
        double __block hendo = 0;
        
        int __block waitTime = 10;
        
        BOOL __block end = NO;
        
        while (YES) {
            end = NO;
            
            [WebAPI requestWithPath:@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDJPY,EURJPY,JPYJPY%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
                              param:nil
                             method:HTTP_METHOD_GET
                         completion:^(BOOL success, id results, NSError *error, NSInteger statusCode) {
                             
//                             LOG(@"result %@",results);
                             
                             currentRate = ((NSString *)results[@"query"][@"results"][@"rate"][0][@"Rate"]).doubleValue;
                             NSLog(@"%@",results[@"query"][@"results"][@"rate"][0][@"Rate"]);
                             
                             hendo = hendo * 0.9 + fabs(prevRate-currentRate)*0.1;
                             
                             if (hendo < 0.01) {
                                 waitTime = 15;
                             }
                             else if (hendo < 0.025) {
                                 waitTime = 10;
                             }
                             else if (hendo < 0.10) {
                                 waitTime = 5;
                             }
                             else {
                                 waitTime = 3;
                             }
                             
                             prevRate = currentRate;
                             end = YES;
                         }];
            
            while (end==NO) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            }
           
//            NSLog(@"%f",currentRate);
//            prevRate = currentRate;
//            
//            if (fabs(prevRate - currentRate) > 0.05) {
//                waitTime =
//            }
            
            [NSThread sleepForTimeInterval:waitTime];
        }

    }
    return 0;
}

