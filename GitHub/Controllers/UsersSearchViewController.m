//
//  UsersSearchViewController.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UsersSearchViewController.h"

#import "UsersSearchHeaderView.h"
#import "UsersSearchCell.h"

#import "UsersSearchRootModel.h"
#import "UserRootModel.h"
#import "LanguageRootModel.h"
#import "UserInfomationModel.h"

@interface UsersSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UsersSearchHeaderViewDelegate, UsersSearchCellDelegate>

@property (nonatomic, strong) UsersSearchRootModel  *rootModel;
@property (nonatomic, strong) UsersSearchHeaderView *hearchView;
@property (nonatomic, strong) UsersSearchCell       *cell;
@property (nonatomic, strong) UITableView           *tableView;

@property (nonatomic, strong) NSMutableArray *usersDatasArray;

@end

@implementation UsersSearchViewController

//懒加载
- (NSMutableArray *)usersDatasArray {
    
    if (_usersDatasArray == nil) {
        
        _usersDatasArray = [[NSMutableArray alloc] init];
    }
    return _usersDatasArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //  创建表头搜索框
    [self createHeaderView];
    
    //  创建tableView
    [self createTableView];
    
}

- (void) createHeaderView {
    
    CGRect frame      = CGRectZero;
    frame.origin.x    = 0;
    frame.origin.y    = 0;
    frame.size.width  = View_Width;
    frame.size.height = 64;
    
    UsersSearchHeaderView *headerView = [[UsersSearchHeaderView alloc] init];
    headerView.frame                  = frame;
    headerView.delegate               = self;
    [headerView buildView];
    [self.view addSubview:headerView];
    self.hearchView = headerView;
    
}

#pragma mark - headerView代理方法
- (void) getUsersAccountWithArray:(NSArray *)itemsArray {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.usersDatasArray removeAllObjects];
        
        NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
        
        for (Items *item in itemsArray) {
            
            UserInfomationModel *userInfomationModel = [[UserInfomationModel alloc] init];
            
            userInfomationModel.login      = item.login;
            userInfomationModel.url        = item.url;
            userInfomationModel.repos_url  = item.repos_url;
            userInfomationModel.avatar_url = item.avatar_url;
            userInfomationModel.isLoadData = NO;
            [tmpDataArray addObject:userInfomationModel];
            
        }
        
        self.usersDatasArray = [tmpDataArray mutableCopy];
        
        [self.tableView reloadData];
        
    });
    
}

- (void) createTableView {
    
    CGRect frame      = CGRectZero;
    frame.origin.x    = 0;
    frame.origin.y    = 64;
    frame.size.width  = View_Width;
    frame.size.height = View_Height - 64;
    
    UITableView *tableView    = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate        = self;
    tableView.dataSource      = self;
    tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UsersSearchCell class] forCellReuseIdentifier:@"UsersSearchCell"];
    
    self.tableView = tableView;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(clickView)];
    tapGestureRecognizer.cancelsTouchesInView    = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void) clickView {

    [self.hearchView searchBarResignFirstResponder];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.usersDatasArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIFont *font  = [UIFont systemFontOfSize:12.f];
    CGFloat width = 0;
    if (iPhone5_5s) {
        
        font  = [UIFont systemFontOfSize:12.f];
        width = 60;
        
    } else if (iPhone6_6s) {
        
        font  = [UIFont systemFontOfSize:13.f];
        width = 65;
        
    } else if (iPhone6_6sPlus) {
        
        font  = [UIFont systemFontOfSize:14.f];
        width = 70;
        
    } else {
        
        font  = [UIFont systemFontOfSize:12.f];
        width = 60;
        
    }
    
    UserInfomationModel *model = self.usersDatasArray[indexPath.row];
    CGSize size = [self sizeWithString:model.language font:font width:(Width - 32 - width - 10)];
    
    CGFloat cell_height = size.height + width;
    cell_height         = cell_height > width + 20 ? cell_height : width + 20;
    
    return cell_height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UsersSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UsersSearchCell"
                                                            forIndexPath:indexPath];
    
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.delegate         = self;
    
    UserInfomationModel *userInfomationModel = self.usersDatasArray[indexPath.row];
    userInfomationModel.tag                  = indexPath.row;
    
    cell.data = userInfomationModel;
    
    if (userInfomationModel.isLoadData == NO) {
        
        //  清空cell
        [cell cleanData];
        
        //  获取网络json数据
        [cell getNetWorkingData];
        
        userInfomationModel.isLoadData = YES;
        
        [self.usersDatasArray replaceObjectAtIndex:indexPath.row withObject:userInfomationModel];
        
    } else {
        
        //  刷新数据
        [cell loadData];
        
    }
    
    return cell;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.hearchView searchBarResignFirstResponder];
    
}

#pragma mark - cell代理方法
- (void) getUserNameInformationUrlWithUrlString:(NSString *)urlString withTag:(NSInteger)cellTag; {
    
    //  启动网络获取用户昵称及图片地址信息及语言使用情况
    HttpToolForCell *httpTool = [[HttpToolForCell alloc] init];
    
    //  启动网络进行数据请求
    [httpTool lxfGetWithURL:urlString params:nil success:^(id data) {
        
        [self getUserRequestSucessWithData:data withTag:cellTag];
        
    } failure:^(NSError *error) {
        
        [self getUserRequestFailedWithError:error];
        
    }];
    
    return;
    
}

//  为语言label请求数据并赋值
- (void) getUserLanguageInformationUrlWithUrlString:(NSString *)urlString withTag:(NSInteger)cellTag; {
    
    //  启动网络获取用户昵称及图片地址信息及语言使用情况
    HttpToolForCell *httpTool = [[HttpToolForCell alloc] init];
    
    //  启动网络进行数据请求
    [httpTool lxfGetWithURL:urlString params:nil success:^(id data) {
        
        [self getUserLanguageRequestSucessWithData:data withTag:cellTag];
        
    } failure:^(NSError *error) {
        
        [self getUserLanguageRequestFailedWithError:error];
        
    }];
    
    return;
    
}

#pragma mark - 获取用户昵称和图像地址信息成功或失败处理
- (void) getUserRequestSucessWithData:(id)data withTag:(NSInteger)cellTag {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UserRootModel       *rootModel = [[UserRootModel alloc] initWithDictionary:data];
        UserInfomationModel *model     = self.usersDatasArray[cellTag];
        
        if (rootModel.name.length == 0) {
            
            model.name = rootModel.login;
            
        } else {
            
            model.name = rootModel.name;
            
        }
        
        [self.usersDatasArray replaceObjectAtIndex:cellTag withObject:model];
        
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:cellTag inSection:0];
        NSArray     *indexArray = [NSArray arrayWithObject:indexPath];
        
        UsersSearchCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UsersSearchCell" forIndexPath:indexPath];
        cell.data             = model;
        
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];

    });
    
}

- (void) getUserRequestFailedWithError:(NSError *)error; {
    
    NSLog(@"用户没有数据");
    
}

#pragma mark - 获取用户语言成功或失败处理
- (void) getUserLanguageRequestSucessWithData:(id)data withTag:(NSInteger)cellTag {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        LanguageRootModel *languageModel = [[LanguageRootModel alloc] initWithArray:data];
        
        NSString *language = [languageModel getMostUseLanguageMessageWithArray:languageModel.languageArray];
        
        UserInfomationModel *model = self.usersDatasArray[cellTag];
        
        model.language = language;
        
        [self.usersDatasArray replaceObjectAtIndex:cellTag withObject:model];
        
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:cellTag inSection:0];
        NSArray     *indexArray = [NSArray arrayWithObject:indexPath];
        
        UsersSearchCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UsersSearchCell" forIndexPath:indexPath];
        cell.data             = model;
        
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        
    });
    
}

- (void) getUserLanguageRequestFailedWithError:(NSError *)error; {
    
    NSLog(@"用户语言没有数据");
    
}

//  计算文字高度
- (CGSize) sizeWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 900)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName : font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

@end
