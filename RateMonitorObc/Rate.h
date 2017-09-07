//
//  Rate.h
//  RateMonitorObc
//
//  Created by osanai on 2017/09/07.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RateType) {
    kUSDJPY,
    kEURUSD,
    kEURJPY,
    kGBPJPY,
    kGBPUSD,
    kEURGBP,
    kUSDCAD,
    kCADJPY,
    kAUDJPY,
    kAUDUSD,
    kZARJPY,
    kUSDZAR,
    kUSDTRY,
    kTRYJPY,
};

typedef NS_ENUM(NSUInteger, RateMove) {
    kLarge,     // ちょううごいた
    kMidium,    // まぁまぁうごいた
    kLittle,    // ちょっと
    kNormal,    // それほどうごいてない
};

@interface Rate : NSObject

@property (nonatomic) NSString *typeString;
@property (nonatomic) RateType rateType;
@property (nonatomic) double value;
@property (nonatomic) NSDate *date;

+ (Rate *)createWithDic:(NSDictionary *)dic;
- (double)pips;

// 動いた？
+ (RateMove)isMove:(double)pips
       forRateType:(RateType)rateType
           zouhuku:(double)z;
@end

