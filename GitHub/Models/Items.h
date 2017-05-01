//
//  Items.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items : NSObject

//  用户登录名
@property (nonatomic, strong) NSString *login;

//  用户ID
@property (nonatomic, strong) NSNumber *user_id;

//  用户头像URL
@property (nonatomic, strong) NSString *avatar_url;

//  用户信息URL
@property (nonatomic, strong) NSString *url;

//  用户项目信息URL
@property (nonatomic, strong) NSString *repos_url;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
