//
//  DownloadImage.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "DownloadImage.h"

@implementation DownloadImage

+ (void) downloadImageForImageView:(UIImageView *)imageView
                          imageUrl:(NSURL *)url
                  placeholderImage:(NSString *)placeholderImageString
                          progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progress
                           success:(void (^)(UIImage *finishImage))success; {
        
    if ([url.scheme isEqualToString:@"https"]) {
        
        [imageView sd_setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:placeholderImageString]
                              options:SDWebImageRetryFailed|SDWebImageProgressiveDownload|SDWebImageAllowInvalidSSLCertificates
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 
                                 progress(receivedSize, expectedSize);
                                 
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                
                                success(image);
                                
                            }];
        
    } else {
        
        [imageView sd_setImageWithURL:url
                     placeholderImage:[UIImage imageNamed:placeholderImageString]
                              options:SDWebImageRetryFailed|SDWebImageProgressiveDownload
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 
                                 progress(receivedSize, expectedSize);
                                 
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                
                                success(image);
                                
                            }];
        
    }
    
}

@end
