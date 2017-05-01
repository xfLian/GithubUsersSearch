//
//  UsersSearchHeaderView.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UsersSearchHeaderViewDelegate <NSObject>

- (void) getUsersAccountWithArray:(NSArray *)itemsArray;

@end

@interface UsersSearchHeaderView : UIView

@property (nonatomic, weak) id<UsersSearchHeaderViewDelegate> delegate;

//  接受请求参数
@property (nonatomic, copy) NSString *userLogIn;

//  创建view
- (void) buildView;

- (void) searchBarResignFirstResponder;

@end
