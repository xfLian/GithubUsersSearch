//
//  HttpToolForCell.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpToolForCell : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfGetWithURL:(NSString *)url
                params:(NSDictionary *)params
               success:(void (^)(id data))success
               failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url             请求路径
 *  @param params          请求参数
 *  @param success         请求成功后的回调
 *  @param failure         请求失败后的回调
 *
 */
- (void) lxfPostWithURL:(NSString *)url
                 params:(NSDictionary *)params
                success:(void (^)(id data))success
                failure:(void (^)(NSError *error))failure;

//  取消网络请求
- (void) cancelOperations;

@end
