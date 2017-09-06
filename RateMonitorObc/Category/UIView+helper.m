//
//  UIView+helper.m
//  MyBestHouse
//
//  Created by osanaikoutarou on 2015/03/23.
//  Copyright (c) 2015年 osanaikoutarou. All rights reserved.
//

#import "UIView+helper.h"

@implementation UIView (helper)

- (void)setSize:(CGSize)size {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
}

- (CGFloat)frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

@end
