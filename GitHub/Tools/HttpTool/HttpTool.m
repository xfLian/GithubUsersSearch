//
//  HttpTool.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "HttpTool.h"
#import "HttpsManager.h"

@interface HttpTool()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDataTask *urlSessionTask;

@end

@implementation HttpTool

static HttpTool *_httpTool;

+ (instancetype) allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        _httpTool = [super allocWithZone:zone];
        
    });
    
    return _httpTool;
}

+ (instancetype) sharedHttpTool {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _httpTool = [[self alloc] init];
        
    });
    
    return _httpTool;
}

- (id) copyWithZone:(NSZone *)zone {
    
    return _httpTool;
    
}

- (void) lxfGetWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failure:(void (^)(NSError *error))failure; {
    
    // 1.创建请求管理对象
    __weak typeof(self) weakSelf  = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManager];
    self.manager                  = manager;
    
    // 2.发送请求
    NSURLSessionDataTask *urlSessionTask = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
    self.urlSessionTask = urlSessionTask;
    
}

- (void)lxfPostWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id data))success failure:(void (^)(NSError *error))failure; {
    
    // 1.创建请求管理对象
    __weak typeof(self) weakSelf  = self;
    AFHTTPSessionManager *manager = [[weakSelf class] getAuthenticationHttpsManager];
    self.manager                  = manager;
    
    // 2.发送请求
    NSURLSessionDataTask *urlSessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            
        }
        
    }];
    
    self.urlSessionTask = urlSessionTask;
    
}

//  获取已经验证过证书的manager
+ (AFHTTPSessionManager *) getAuthenticationHttpsManager {
    
    //  单向验证
    AFHTTPSessionManager *manager = [HttpsManager creatOneWayAuthenticationHttpsManager];
    
    //  双向验证,使用p12证书
    //    AFHTTPSessionManager *manager = [QTHttpsManager creatTwoWayAuthenticationHttpsManagerWithApiName:name];
    
    return manager;
    
}

- (void) cancelAllOperations; {
    
    [self.manager.operationQueue cancelAllOperations];

}

- (void) cancelOperations; {
    
    NSLog(@"取消网络请求");
    [self.urlSessionTask cancel];
    
}

@end
