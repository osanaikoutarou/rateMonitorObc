//
//  Rate.m
//  RateMonitorObc
//
//  Created by osanai on 2017/09/07.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "Rate.h"

@implementation Rate

+ (Rate *)createWithDic:(NSDictionary *)dic {
    
    Rate *rate = [Rate new];

    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return rate;
    }
    
    rate.typeString = dic[@"id"];
    
    if ([dic[@"id"] isEqualToString:@"USDJPY"]) {
        rate.rateType = kUSDJPY;
    }
    if ([dic[@"id"] isEqualToString:@"EURUSD"]) {
        rate.rateType = kEURUSD;
    }
    if ([dic[@"id"] isEqualToString:@"EURJPY"]) {
        rate.rateType = kEURJPY;
    }
    if ([dic[@"id"] isEqualToString:@"GBPJPY"]) {
        rate.rateType = kGBPJPY;
    }
    if ([dic[@"id"] isEqualToString:@"GBPUSD"]) {
        rate.rateType = kGBPUSD;
    }
    if ([dic[@"id"] isEqualToString:@"EURGBP"]) {
        rate.rateType = kEURGBP;
    }
    if ([dic[@"id"] isEqualToString:@"USDCAD"]) {
        rate.rateType = kUSDCAD;
    }
    if ([dic[@"id"] isEqualToString:@"CADJPY"]) {
        rate.rateType = kCADJPY;
    }
    if ([dic[@"id"] isEqualToString:@"AUDJPY"]) {
        rate.rateType = kAUDJPY;
    }
    if ([dic[@"id"] isEqualToString:@"AUDUSD"]) {
        rate.rateType = kAUDUSD;
    }
    if ([dic[@"id"] isEqualToString:@"ZARJPY"]) {
        rate.rateType = kZARJPY;
    }
    if ([dic[@"id"] isEqualToString:@"USDJPY"]) {
        rate.rateType = kUSDJPY;
    }
    if ([dic[@"id"] isEqualToString:@"USDZAR"]) {
        rate.rateType = kUSDZAR;
    }
    if ([dic[@"id"] isEqualToString:@"USDTRY"]) {
        rate.rateType = kUSDTRY;
    }
    if ([dic[@"id"] isEqualToString:@"TRYJPY"]) {
        rate.rateType = kTRYJPY;
    }
    
    NSString *valueStr = dic[@"Rate"];
    rate.value = valueStr.doubleValue;
    
//    rate.date = 
    
    return rate;
}

- (double)pips {
    if (self.rateType == kUSDJPY) {
        return self.value * 100;
    }
    if (self.rateType == kEURUSD) {
        return self.value * 10000;
    }
    if (self.rateType == kEURJPY) {
        return self.value * 100;
    }
    if (self.rateType == kGBPJPY) {
        return self.value * 100;
    }
    if (self.rateType == kEURGBP) {
        return self.value * 10000;
    }
    if (self.rateType == kGBPUSD) {
        return self.value * 10000;
    }
    if (self.rateType == kUSDCAD) {
        return self.value * 10000;
    }
    if (self.rateType == kCADJPY) {
        return self.value * 100;
    }
    if (self.rateType == kAUDJPY) {
        return self.value * 100;
    }
    if (self.rateType == kAUDUSD) {
        return self.value * 10000;
    }
    if (self.rateType == kZARJPY) {
        return self.value * 1000;
    }
    if (self.rateType == kUSDZAR) {
        return self.value * 1000;
    }
    if (self.rateType == kUSDTRY) {
        return self.value * 10000;
    }
    if (self.rateType == kTRYJPY) {
        return self.value * 1000;
    }
    
    return 0;
}

+ (RateMove)isMove:(double)pips
       forRateType:(RateType)rateType
           zouhuku:(double)z { // 動いた？
    
    // ドル円を基準
    double large = 30;
    double midium = 20;
    double little = 5;
    
    double bairitu = 1;
    
    if (rateType == kUSDJPY) {
        bairitu = 1;
    }
    if (rateType == kEURUSD) {
        bairitu = 1;
    }
    if (rateType == kEURJPY) {
        bairitu = 1.1;
    }
    if (rateType == kGBPJPY) {
        bairitu = 1.2;
    }
    if (rateType == kEURGBP) {
        bairitu = 0.9;
    }
    if (rateType == kGBPUSD) {
        bairitu = 0.9;
    }
    if (rateType == kUSDCAD) {
        bairitu = 1;
    }
    if (rateType == kCADJPY) {
        bairitu = 1;
    }
    if (rateType == kAUDJPY) {
        bairitu = 1;
    }
    if (rateType == kAUDUSD) {
        bairitu = 1;
    }
    if (rateType == kZARJPY) {
        bairitu = 10;
    }
    if (rateType == kUSDZAR) {
        bairitu = 2;
    }
    if (rateType == kUSDTRY) {
        bairitu = 3;
    }
    if (rateType == kTRYJPY) {
        bairitu = 10;
    }
    
    bairitu *= z;
    
    // 通常
    if (pips > large * bairitu) {
        return kLarge;
    }
    if (pips > midium * bairitu) {
        return kMidium;
    }
    if (pips > little * bairitu) {
        return kLittle;
    }
    
    return kNormal;
}
@end
