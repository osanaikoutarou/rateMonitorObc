//
//  UIImageView+Creator.m
//  Kenchikukatachi
//
//  Created by 長内幸太郎 on 2017/04/20.
//  Copyright © 2017年 長内幸太郎. All rights reserved.
//

#import "UIImageView+Creator.h"

@implementation UIImageView (Creator)

+ (UIImageView *)createImageName:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
