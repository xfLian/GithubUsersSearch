//
//  UserInfomationModel.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfomationModel : NSObject

@property (nonatomic, strong) NSString  *login;
@property (nonatomic, strong) NSString  *url;
@property (nonatomic, strong) NSString  *repos_url;
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *avatar_url;
@property (nonatomic, strong) NSString  *language;
@property (nonatomic, strong) UIImage   *image;
@property (nonatomic, assign) NSInteger  tag;

@property (nonatomic, assign) BOOL       isLoadData;
@property (nonatomic, assign) BOOL       isSuccessLoadData;

@end
