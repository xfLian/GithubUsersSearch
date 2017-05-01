//
//  LXFSearchBarView.m
//  image
//
//  Created by qiantang on 17/1/5.
//  Copyright © 2017年 qiantang. All rights reserved.
//

#import "LXFSearchBarView.h"

#define View_Width  [UIScreen mainScreen].bounds.size.width
#define View_Height [UIScreen mainScreen].bounds.size.height

@interface LXFSearchBarView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIView      *contentView;
@property (nonatomic, strong) UIView      *textFieldBackView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton    *clearButton;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL isClickReturnkey;

@end

@implementation LXFSearchBarView

- (void) creatSearchBar {
    
    self.isCreateDefaultSearchBar = NO;
    
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    
    //  创建背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.bounds.size.width, windows.bounds.size.height)];
    [windows addSubview:backView];
    self.backView = backView;
    
    //  创建容器view
    UIView   *contentView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.bounds.size.width, windows.bounds.size.height)];
    contentView.backgroundColor = [UIColor grayColor];
    contentView.alpha           = 0.4f;
    [backView addSubview:contentView];
    
    UIView *textFieldBackView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    textFieldBackView.layer.cornerRadius  = textFieldBackView.frame.size.width / 2;
    textFieldBackView.layer.masksToBounds = YES;
    textFieldBackView.layer.borderWidth   = 0.5f;
    textFieldBackView.layer.borderColor   = [[UIColor blackColor] CGColor];
    textFieldBackView.backgroundColor     = [UIColor clearColor];
    [backView addSubview:textFieldBackView];
    textFieldBackView.center = CGPointMake(View_Width / 2, 50);
    self.textFieldBackView = textFieldBackView;
    
    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image           = [UIImage imageNamed:@"search-icon"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode     = UIViewContentModeScaleToFill;
    [textFieldBackView addSubview:imageView];
    self.imageView = imageView;
    
    CGRect textFieldFrame = CGRectZero;
    textFieldFrame.origin.x = 0;
    textFieldFrame.origin.y = 0;
    textFieldFrame.size.width = textFieldBackView.frame.size.width - (imageView.frame.origin.x + imageView.frame.size.width) *2;
    textFieldFrame.size.height = textFieldBackView.frame.size.height;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.keyboardType = UIKeyboardTypeDefault;
    [textFieldBackView addSubview:textField];
    textField.hidden = YES;
    self.textField = textField;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarHide)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [contentView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void) searchBarHide {

    [self hide];
        
}

- (void) show {
    
    if (self.isCreateDefaultSearchBar == YES) {
        
        [self createDefaultSearchBarWithTextFieldFrame:self.frame
                                       backgroundColor:self.backgroundColor
                                           borderWidth:self.borderWidth
                                           borderColor:self.borderColor
                                             textColor:self.textColor
                                              textFont:self.textFont
                                           placeholder:self.placeholder
                                      placeholderColor:self.placeholderColor
                                       placeholderFont:self.placeholderFont
                                     isHaveClearButton:self.isHaveClearButton
                                          keyboardType:self.keyboardType
                                    keyboardAppearance:self.keyboardAppearance
                                         returnKeyType:self.returnKeyType];
        
    } else {
        
        [self creatSearchBar];
    
    }
    
    self.clearButton.hidden = NO;
    
    [UIView animateWithDuration:0.75f animations:^{
        
        CGRect frame     = self.textFieldBackView.frame;
        frame.size.width = View_Width - 24;
        self.textFieldBackView.frame  = frame;
        self.textFieldBackView.center = CGPointMake(View_Width / 2, frame.origin.y + frame.size.height / 2);
        
        CGRect clearButtonFrame   = self.clearButton.frame;
        clearButtonFrame.origin.x = self.textFieldBackView.frame.size.width - clearButtonFrame.size.width;
        self.clearButton.frame    = clearButtonFrame;
        
    } completion:nil];
    
    [GCDQueue executeInMainQueue:^{
        
        self.textField.hidden = NO;
        CGRect textFieldFrame      = self.textField.frame;
        textFieldFrame.origin.x    = self.imageView.frame.origin.x *2 + self.imageView.frame.size.width;
        textFieldFrame.size.width  = self.textFieldBackView.frame.size.width - textFieldFrame.origin.x *2;
        self.textField.frame       = textFieldFrame;
        
        [self.textField becomeFirstResponder];
        
    } afterDelaySecs:0.25f];
    
}

- (void) hide {
    
    [self.textField resignFirstResponder];
    self.textField.hidden   = YES;
    self.clearButton.hidden = YES;
    
    [UIView animateWithDuration:0.75f animations:^{
        
        CGRect frame     = self.textFieldBackView.frame;
        frame.size.width = frame.size.height;
        self.textFieldBackView.frame  = frame;
        self.textFieldBackView.center = CGPointMake(View_Width / 2, frame.origin.y + frame.size.height / 2);
        
    } completion:^(BOOL finished) {
        
        CGRect textFieldFrame      = self.textField.frame;
        textFieldFrame.origin.x    = 0;
        self.textField.frame = textFieldFrame;
        
        for (UIView *view in self.backView.subviews) {
            
            [view removeFromSuperview];
            
        }
        
        [self.backView removeFromSuperview];
        
        [_delegate hideSearchBarViewFinsh];
        
    }];
    
}

- (void) clickReturnkeyHideView {
    
    [self.textField resignFirstResponder];
    self.textField.hidden   = YES;
    self.clearButton.hidden = YES;
    
    [UIView animateWithDuration:0.25f animations:^{
        
        CGRect frame     = self.textFieldBackView.frame;
        frame.size.width = frame.size.height;
        self.textFieldBackView.frame  = frame;
        self.textFieldBackView.center = CGPointMake(View_Width / 2, frame.origin.y + frame.size.height / 2);
        
    } completion:^(BOOL finished) {
        
        CGRect textFieldFrame      = self.textField.frame;
        textFieldFrame.origin.x    = 0;
        self.textField.frame = textFieldFrame;
        
        for (UIView *view in self.backView.subviews) {
            
            [view removeFromSuperview];
            
        }
        
        [self.backView removeFromSuperview];
        
        [_delegate getTextFieldText:self.textField.text];
        
    }];
    
}

- (void) createDefaultSearchBarWithTextFieldFrame:(CGRect)frame
                                  backgroundColor:(UIColor *)backgroundColor
                                      borderWidth:(CGFloat)borderWidth
                                      borderColor:(UIColor *)borderColor
                                        textColor:(UIColor *)textColor
                                         textFont:(CGFloat)textFont
                                      placeholder:(NSString *)placeholder
                                 placeholderColor:(UIColor *)placeholderColor
                                  placeholderFont:(CGFloat)placeholderFont
                                isHaveClearButton:(BOOL)isHaveClearButton
                                     keyboardType:(UIKeyboardType)keyboardType
                               keyboardAppearance:(UIKeyboardAppearance)keyboardAppearance
                                    returnKeyType:(UIReturnKeyType)returnKeyType; {
    
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    
    //  创建背景view
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.bounds.size.width, windows.bounds.size.height)];
    [windows addSubview:backView];
    self.backView = backView;
    
    //  创建容器view
    UIView   *contentView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windows.bounds.size.width, windows.bounds.size.height)];
    contentView.backgroundColor = [UIColor grayColor];
    contentView.alpha           = 0.4f;
    [backView addSubview:contentView];
    
    UIView *textFieldBackView             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
    textFieldBackView.layer.cornerRadius  = textFieldBackView.frame.size.width / 2;
    textFieldBackView.layer.masksToBounds = YES;
    textFieldBackView.layer.borderWidth   = borderWidth;
    textFieldBackView.layer.borderColor   = [borderColor CGColor];
    textFieldBackView.backgroundColor     = backgroundColor;
    [backView addSubview:textFieldBackView];
    textFieldBackView.center = CGPointMake(View_Width / 2, frame.origin.y + frame.size.height / 2);
    self.textFieldBackView = textFieldBackView;
    
    UIImageView *imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height / 4, frame.size.height / 4, frame.size.height / 2, frame.size.height / 2)];
    imageView.image           = [UIImage imageNamed:@"search-icon"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode     = UIViewContentModeScaleToFill;
    [textFieldBackView addSubview:imageView];
    self.imageView = imageView;
    
    CGRect textFieldFrame      = CGRectZero;
    textFieldFrame.origin.x    = imageView.frame.origin.x *2 + imageView.frame.size.width;
    textFieldFrame.origin.y    = 0;
    textFieldFrame.size.width  = textFieldBackView.frame.size.width - textFieldFrame.origin.x *2;
    textFieldFrame.size.height = textFieldBackView.frame.size.height;
    
    UITextField *textField       = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.textColor          = textColor;
    textField.font               = [UIFont fontWithName:PF_LIGHT size:textFont];
    textField.keyboardType       = keyboardType;
    textField.keyboardAppearance = keyboardAppearance;
    textField.returnKeyType      = returnKeyType;
    textField.placeholder        = placeholder;
    textField.delegate           = self;
    textField.tintColor          = [UIColor blackColor];
    [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont fontWithName:PF_LIGHT size:placeholderFont] forKeyPath:@"_placeholderLabel.font"];
    [textFieldBackView addSubview:textField];
    textField.hidden = YES;
    self.textField = textField;
    
    if (isHaveClearButton == YES) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      frame.size.height,
                                                                      frame.size.height)];
        [button setImage:[UIImage imageNamed:@"close-icon"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [textFieldBackView addSubview:button];
        self.clearButton = button;
        button.hidden = YES;
        
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarHide)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [contentView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void) buttonEvent:(UIButton *)sender {

    self.textField.text = nil;

}

#pragma mark - textField代理
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    
    //  返回一个BOOL值，指定是否循序文本字段开始编辑
    
    return YES;
    
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    //  开始编辑时触发，文本字段将成为first responder
    
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    
    //  返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
    //  要想在用户结束编辑时阻止文本字段消失，可以返回NO
    //  这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息

    return YES;
    
}

- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //  当用户使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
    //  这对于想要加入撤销选项的应用程序特别有用
    //  可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录,用作审计用途。
    //  要防止文字被改变可以返回NO
    //  这个方法的参数中有一个NSRange对象，指明了被改变文字的位置，建议修改的文本也在其中
    
    return YES;
    
}

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    
    //  返回一个BOOL值指明是否允许根据用户请求清除内容
    //  可以设置在特定条件下才允许清除内容
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    //  返回一个BOOL值，指明是否允许在按下回车键时结束编辑
    //  如果允许要调用resignFirstResponder方法，这会导致结束编辑，而键盘会被收起[textField resignFirstResponder];
    //  查一下resign这个单词的意思就明白这个方法了
    
    self.isClickReturnkey = YES;
    
    [self clickReturnkeyHideView];
    
    return YES;
    
}

@end
