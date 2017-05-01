//
//  UsersSearchRootModel.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Items.h"

@interface UsersSearchRootModel : NSObject

@property (nonatomic, strong) NSString          *total_count;
@property (nonatomic, strong) NSString          *incomplete_results;
@property (nonatomic, strong) NSArray <Items *> *items;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
