//
//  main.m
//  RateMonitorObc
//
//  Created by osanai on 2017/09/04.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebAPI.h"
#import "Rate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!a");
        
        double __block prevRate = 100;
        double __block currentRate = 100;
        
        double __block hendo = 0;
        
        int __block waitTime = 13;
        
        BOOL __block end = NO;
        
        NSMutableDictionary __block *prevDic = [NSMutableDictionary dictionary];
        NSMutableDictionary __block *currentDic = [NSMutableDictionary dictionary];
        
        while (YES) {
            end = NO;
            
            [WebAPI requestWithPath:@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDJPY,EURUSD,EURJPY,EURGBP,USDCAD,CADJPY,AUDJPY,AUDUSD,ZARJPY,USDZAR,USDTRY,TRYJPY,GBPJPY,GBPUSD%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
                              param:nil
                             method:HTTP_METHOD_GET
                         completion:^(BOOL success, id results, NSError *error, NSInteger statusCode) {
                             
//                             LOG(@"result %@",results);
                             
                             for (NSDictionary *dic in results[@"query"][@"results"][@"rate"]) {
                                 Rate *rate = [Rate createWithDic:dic];
                                 if (rate.typeString && rate.typeString.length>0) {
                                     [currentDic setObject:rate forKey:rate.typeString];
                                 }
                             }
                             
                             for (NSString *key in currentDic.allKeys) {
                                 Rate *current = currentDic[key];
                                 Rate *prev = prevDic[key];
                                 
                                 if (!current || !prev) {
                                     continue;
                                 }

                                //NSLog(@"ペア:%@  前:%f  今:%f  差:%fpips",key,current.value,prev.value,current.pips-prev.pips);
                                 
                                 RateMove move = [Rate isMove:fabs(current.pips - prev.pips)
                                                  forRateType:current.rateType
                                                      zouhuku:1.0];
                                 
                                 if (move == kLittle) {
                                     NSLog(@"%@  %f -> %f (%d) [・]",key,prev.value,current.value,(int)(current.pips-prev.pips));
                                 }
                                 if (move == kMidium) {
                                     NSLog(@"%@  %f -> %f (%d) [◯]",key,prev.value,current.value,(int)(current.pips-prev.pips));
                                 }
                                 if (move == kLarge) {
                                     NSLog(@"%@  %f -> %f (%d) [危]",key,prev.value,current.value,(int)(current.pips-prev.pips));
                                 }
                             }
                             
                             if (currentDic[@"USDJPY"] && prevDic[@"USDJPY"]) {
                                 NSLog(@" ");

                                 Rate *c = currentDic[@"USDJPY"];
                                 Rate *p = prevDic[@"USDJPY"];
                                 NSString *kigo = @"+";
                                 if (c.value < p.value) {
                                     kigo = @"-";
                                 }
                                 NSLog(@"usdjpy %f %@%d",((Rate *)currentDic[@"USDJPY"]).value,kigo,(int)fabs(c.pips-p.pips));
                             }
                            
                             prevDic = [[NSMutableDictionary alloc] initWithDictionary:currentDic];
                             
                             
//                             currentRate = ((NSString *)results[@"query"][@"results"][@"rate"][0][@"Rate"]).doubleValue;
//                             NSLog(@"%@",results[@"query"][@"results"][@"rate"][0][@"Rate"]);
//                             hendo = hendo * 0.9 + fabs(prevRate-currentRate)*0.1;
//                             
//                             if (hendo < 0.01) {
//                                 waitTime = 20;
//                             }
//                             else if (hendo < 0.025) {
//                                 waitTime = 12;
//                             }
//                             else if (hendo < 0.10) {
//                                 waitTime = 5;
//                             }
//                             else {
//                                 waitTime = 3;
//                             }
//                             
//                             prevRate = currentRate;
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

