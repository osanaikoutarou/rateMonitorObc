//
//  KeyboardController.m
//
//  Created by osanai on 2017/07/11.
//  Copyright © 2017年 osanai. All rights reserved.
//

#import "KeyboardController.h"

typedef NS_ENUM(NSUInteger, TargetViewType) {
    kScrollView = 1,
    kTableView,
//    kCollectionView,    // 未実装
//    kTextView,          // 未実装
};

@implementation KeyboardController {
    TargetViewType type;
    UIEdgeInsets defaultInsets;
    
    UIScrollView *targetScrollView;
    UITableView *targetTableView;
//    UICollectionView *targetCollectionView;
//    UITextView *targetTextView;
}

- (void)setupWithTarget:(UIView *)targetView {
    if ([targetView isKindOfClass:[UIScrollView class]]) {
        type = kScrollView;
        targetScrollView = (UIScrollView *)targetView;
        defaultInsets = targetScrollView.contentInset;
    }
    
    if ([targetView isKindOfClass:[UITableView class]]) {
        type = kTableView;
        targetTableView = (UITableView *)targetView;
        defaultInsets = targetTableView.contentInset;
    }
    
    // typeを追加する場合ここに追記
}

- (UIView *)targetView {
    if (type == kScrollView) {
        return targetScrollView;
    }
    if (type == kTableView) {
        return targetTableView;
    }
    
    // typeを追加する場合ここに追記
    return [UIView new];
}

- (void)setupKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

// Shown
- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    CGRect aRect = self.targetView.frame;
    aRect.size.height -= kbSize.height;
    
    // scrollViewの場合
    if (type == kScrollView) {
        targetScrollView.contentInset = contentInsets;
        targetScrollView.scrollIndicatorInsets = contentInsets;
    }
    
    // tableViewの場合
    if (type == kTableView) {
        targetTableView.contentInset = contentInsets;
        targetTableView.scrollIndicatorInsets = contentInsets;
    }
    
    // typeを追加する場合ここに追記
}

// Hide
- (void)keyboardWillHide:(NSNotification *)aNotification {
    // scrollViewの場合
    if (type == kScrollView) {
        targetScrollView.contentInset = defaultInsets;
        targetScrollView.scrollIndicatorInsets = defaultInsets;
    }
    // tableViewの場合
    if (type == kTableView) {
        targetTableView.contentInset = defaultInsets;
        targetTableView.contentInset = defaultInsets;
    }
    
    // typeを追加する場合ここに追記
}

#pragma mark - util

- (void)closeKeyboard:(UIViewController *)vc {
    [vc.view endEditing:YES];
}

@end
