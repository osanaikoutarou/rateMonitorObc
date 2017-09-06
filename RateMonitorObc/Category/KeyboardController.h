//
//  KeyboardController.h
//
//  Created by osanai on 2017/07/11.
//  Copyright © 2017年 osanai. All rights reserved.
//

// 概要
// Keyboard出現時のScrollViewの調整を代行するクラスです
// Keyboardの高さ分スクロールを可能にします(contentInsetによる調整)

// その他
// ・BaseViewControllerに追加したくない場合に使用してください
// ・現状、UIScrollViewにしか対応していません
// ・タップイベント、タッチイベント、スクロールイベントとの干渉に注意してください
// ・ScrollViewの場合、ScrollViewの下にContentViewを用意し、ContentView=Visible領域となるようにレイアウトを組みます

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KeyboardController : NSObject

//MARK:Require

// viewDidAppearで呼んでください
- (void)setupWithTarget:(UIView *)targetView;
// viewWillAppearで呼んでください
- (void)setupKeyboardNotification;
// viewWillDisappearで呼んでください
- (void)removeKeyboardNotification;

#pragma mark - util

- (void)closeKeyboard:(UIViewController *)vc;

@end
