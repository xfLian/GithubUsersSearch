//
//  UsersSearchCell.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UsersSearchCellDelegate<NSObject>

//  为昵称label请求数据并赋值
- (void) getUserNameInformationUrlWithUrlString:(NSString *)urlString withTag:(NSInteger)cellTag;

//  为语言label请求数据并赋值
- (void) getUserLanguageInformationUrlWithUrlString:(NSString *)urlString withTag:(NSInteger)cellTag;

@end

@interface UsersSearchCell : UITableViewCell

@property (strong, nonatomic) id <UsersSearchCellDelegate> delegate;

@property (nonatomic, strong) id data;

- (void) cleanData;

- (void) loadData;

- (void) getNetWorkingData;

@end
