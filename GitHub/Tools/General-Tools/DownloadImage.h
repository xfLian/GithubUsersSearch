//
//  DownloadImage.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadImage : NSObject

/**
 *  下载图片
 *  
 *  @param imageView                图片view
 *  @param url                      图片地址
 *  @param placeholderImageString   默认图片
 *  @param progress                 下载中
 *  @param success                  下载成功回调
 *
 */
+ (void) downloadImageForImageView:(UIImageView *)imageView
                          imageUrl:(NSURL *)url
                  placeholderImage:(NSString *)placeholderImageString
                          progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progress
                           success:(void (^)(UIImage *finishImage))success;

@end
