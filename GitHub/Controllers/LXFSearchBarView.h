//
//  LXFSearchBarView.h
//  image
//
//  Created by qiantang on 17/1/5.
//  Copyright © 2017年 qiantang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXFSearchBarViewDelegate <NSObject>

- (void) hideSearchBarViewFinsh;
- (void) getTextFieldText:(NSString *)text;

@end

@interface LXFSearchBarView : UIView

@property (nonatomic, weak) id<LXFSearchBarViewDelegate> delegate;

/**
 *
 *  便利构造器
 *
 *  @ frame                textField尺寸值
 *
 *  @ backgroundColor      searchBar背景色
 *
 *  @ borderWidth          边框宽度
 *
 *  @ borderColor          边框颜色
 *
 *  @ textColor            字体颜色
 *
 *  @ textFont             字体大小
 *
 *  @ placeholder          默认字体
 *
 *  @ placeholderColor     默认字体颜色
 *
 *  @ placeholderFont      默认字体大小
 *
 *  @ isHaveClearButton    是否有清空内容按钮
 *
 *  @ keyboardType         键盘样式
 *
 *  @ keyboardAppearance   键盘外观
 *
 *  @ returnKeyType        返回键样式
 *
 */
@property (nonatomic, assign) BOOL                  isCreateDefaultSearchBar;
@property (nonatomic, assign) CGRect                frame;
@property (nonatomic, strong) UIColor              *backgroundColor;
@property (nonatomic, assign) CGFloat               borderWidth;
@property (nonatomic, strong) UIColor              *borderColor;
@property (nonatomic, strong) UIColor              *textColor;
@property (nonatomic, assign) CGFloat               textFont;
@property (nonatomic, strong) NSString             *placeholder;
@property (nonatomic, strong) UIColor              *placeholderColor;
@property (nonatomic, assign) CGFloat               placeholderFont;
@property (nonatomic, assign) BOOL                  isHaveClearButton;
@property (nonatomic, assign) UIKeyboardType        keyboardType;
@property (nonatomic, assign) UIKeyboardAppearance  keyboardAppearance;
@property (nonatomic, assign) UIReturnKeyType       returnKeyType;

- (void) show;

- (void) hide;

@end
