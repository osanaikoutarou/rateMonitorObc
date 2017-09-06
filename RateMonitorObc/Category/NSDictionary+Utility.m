//
//  NSDictionary+Utility.m
//  Kenchikukatachi
//
//  Created by 長内幸太郎 on 2017/08/13.
//  Copyright © 2017年 長内幸太郎. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

- (id)firstValue {
    if (self.allValues.count > 0) {
        return self.allValues.firstObject;
    }
    return nil;
}

- (id)firstKey {
    if (self.allKeys.count > 0) {
        return self.allKeys.firstObject;
    }
    return nil;
}

@end
