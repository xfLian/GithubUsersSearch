//
//  UsersSearchHeaderView.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UsersSearchHeaderView.h"

#import "UsersSearchRootModel.h"

@interface UsersSearchHeaderView()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation UsersSearchHeaderView

- (void) buildView {
    
    self.backgroundColor = Color(199, 198, 204);
    
    //  创建搜索框
    {
        
        CGRect frame      = CGRectZero;
        frame.origin.x    = 0;
        frame.origin.y    = 20;
        frame.size.width  = View_Width;
        frame.size.height = 44;
        
        UISearchBar *searchBar = [[UISearchBar alloc]init];
        searchBar.frame        = frame;
        searchBar.delegate     = self;
        [searchBar setPlaceholder:@"请输入关键字"];
        [searchBar setTranslucent:YES];
        [searchBar setSearchTextPositionAdjustment:UIOffsetMake(2, 0)];
        [searchBar setShowsCancelButton:NO];
        [self addSubview:searchBar];
        self.searchBar = searchBar;
        
    }
    
}

//  已经开始进行编辑
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
    
}

//  UISearchBar得到焦点并开始编辑时，执行该方法
- (BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES];
    
    return YES;
    
}

//  UISearchBar结束编辑时，执行该方法
- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO];
    
    return YES;
    
}

//  取消按钮的点击事件
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBarResignFirstResponder];
    
}

//  在键盘中的搜索按钮的点击事件
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchBarResignFirstResponder];
    
}

//  当搜索框中的内容发生改变时会自动进行搜索
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    HttpTool *httpTool = [HttpTool sharedHttpTool];
    
    /**
     *  
     *  判断搜索框是否有内容
     *  1.如果搜索框有内容时
     *    *
     *    *    *  判断内容是否为空格
     *    *    *
     *    *    *  1.不为空格，搜索框内容改变，先取消全部网络请求，再重新进行网络请求；
     *    *    *  2.搜索框内容为空格，不显示内容
     *    *
     *  2.如果没有内容，不显示
     *
     */
    if (searchText.length > 0) {
        
        NSString *message = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([message length] == 0) {
            
            NSLog(@"searchBar --- 全是空格");
            
        } else {
            
            [httpTool cancelOperations];
            
            //  创建数据请求URL及参数
            NSString            *url       = @"https://api.github.com/search/users";
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:searchText forKey:@"q"];
                        
            //  启动网络进行数据请求
            [httpTool lxfGetWithURL:url params:parameter success:^(id data) {
                
                // 获取数据成功
                [self requestSucessWithData:data];
                
            } failure:^(NSError *error) {
                
                // 获取数据失败
                [self requestFailedWithError:error];
                
            }];
        
        }
        
    } else {
        
        
        
    }
    
}

- (void) requestSucessWithData:(id)data; {
    
    UsersSearchRootModel *rootModel = [[UsersSearchRootModel alloc] initWithDictionary:data];
    
    [self.delegate getUsersAccountWithArray:rootModel.items];
    
}

- (void) requestFailedWithError:(NSError *)error; {
    
    NSLog(@"没有数据");

}

- (void) searchBarResignFirstResponder {

    [self.searchBar resignFirstResponder];

}

@end
