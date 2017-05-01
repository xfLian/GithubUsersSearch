//
//  UserRootModel.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRootModel : NSObject

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar_url;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
