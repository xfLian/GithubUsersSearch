//
//  UsersSearchCell.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UsersSearchCell.h"
#import "UsersSearchRootModel.h"
#import "UserInfomationModel.h"

@interface UsersSearchCell()

@property (nonatomic, strong) UserInfomationModel *model;

@property (nonatomic, strong) UIImageView *iconImageView;   //  图片
@property (nonatomic, strong) UILabel     *nameLabel;       //  昵称
@property (nonatomic, strong) UILabel     *titleLabel;   //  编程语言
@property (nonatomic, strong) UILabel     *languageLabel;   //  编程语言

@property (nonatomic, strong) UIView      *languageLabelBackView;

@end

@implementation UsersSearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubViews];
        
    }
    
    return self;
    
}

- (void) initSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *h_top_lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_top_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:h_top_lineView];
    
    //  创建头像imageView
    {
        
        CGRect frame   = CGRectZero;
        frame.origin.x = 12;
        frame.origin.y = 10;
        
        if (iPhone5_5s) {
            
            frame.size.width  = 60;
            frame.size.height = 60;
            
        } else if (iPhone6_6s) {
            
            frame.size.width  = 65;
            frame.size.height = 65;
            
        } else if (iPhone6_6sPlus) {
            
            frame.size.width  = 70;
            frame.size.height = 70;
            
        } else {
            
            frame.size.width  = 60;
            frame.size.height = 60;
            
        }
        
        UIImageView *imageView           = [[UIImageView alloc] initWithFrame:frame];
        imageView.image                  = [UIImage imageNamed:@"github_icon"];
        imageView.contentMode            = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius     = imageView.width / 2;
        imageView.layer.masksToBounds    = YES;
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor        = [UIColor clearColor];
        [self.contentView addSubview:imageView];
        
        self.iconImageView = imageView;
        
    }
    
    //  创建昵称label
    {
        
        CGRect frame       = self.iconImageView.frame;
        frame.origin.x    += frame.size.width + 20;
        frame.origin.y    += 5;
        frame.size.width   = Width - frame.origin.x;
        frame.size.height  = 20;
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text     = @" ";
        label.font     = [UIFont systemFontOfSize:15.f];
        [self addSubview:label];
        self.nameLabel = label;
        label.backgroundColor = [UIColor clearColor];
        
        if (iPhone5_5s) {
            
            label.font = [UIFont systemFontOfSize:16.f];
            
        } else if (iPhone6_6s) {
            
            label.font = [UIFont systemFontOfSize:17.f];
            
        } else if (iPhone6_6sPlus) {
            
            label.font = [UIFont systemFontOfSize:18.f];
            
        } else {
            
            label.font = [UIFont systemFontOfSize:16.f];
            
        }
        
    }
    
    //  创建使用最多编程语言label（可变长度高度label）
    {
        
        CGRect frame   = CGRectZero;
        frame.origin.x = self.iconImageView.x + self.iconImageView.width + 20;
        frame.origin.y = self.iconImageView.y + self.iconImageView.height - 20;
        frame.size.width  = Width - frame.origin.x - 12;
        frame.size.height = 20;
        
        UIView *backView = [[UIView alloc] initWithFrame:frame];
        [self.contentView addSubview:backView];
        self.languageLabelBackView = backView;
        
        UILabel *titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 20)];
        titleLabel.textColor = [UIColor lightGrayColor];
        [backView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.width,
                                                                    0,
                                                                    backView.width - titleLabel.width,
                                                                    backView.height)];
        label.textColor     = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        [backView addSubview:label];
        self.languageLabel = label;
        
        backView.backgroundColor   = [UIColor clearColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        label.backgroundColor      = [UIColor clearColor];
        
        if (iPhone5_5s) {
            
            label.font      = [UIFont systemFontOfSize:12.f];
            titleLabel.font = [UIFont systemFontOfSize:12.f];
            
        } else if (iPhone6_6s) {
            
            label.font      = [UIFont systemFontOfSize:13.f];
            titleLabel.font = [UIFont systemFontOfSize:13.f];
            
        } else if (iPhone6_6sPlus) {
            
            label.font      = [UIFont systemFontOfSize:14.f];
            titleLabel.font = [UIFont systemFontOfSize:14.f];
            
        } else {
            
            label.font      = [UIFont systemFontOfSize:12.f];
            titleLabel.font = [UIFont systemFontOfSize:12.f];
            
        }
        
    }
    
    UIView *h_bottom_lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, View_Width, 0.5f)];
    h_bottom_lineView.backgroundColor = LineColor;
    [self.contentView addSubview:h_bottom_lineView];
    
}

- (void) cleanData {

    //  清空昵称label
    self.nameLabel.text = @" ";
    
    //  清空语言label
    self.titleLabel.text = @" ";
    self.languageLabel.text = @" ";
    
    //  清空头像
    self.iconImageView.image = [UIImage imageNamed:@""];
    
    {
        
        [self.titleLabel sizeToFit];
        
        CGRect frame = self.languageLabel.frame;
        frame.origin.x    = self.titleLabel.x + self.titleLabel.width;
        frame.size.width  = 0;
        frame.size.height = 0;
        self.languageLabel.frame = frame;
        
        CGRect backFrame                 = self.languageLabelBackView.frame;
        backFrame.size.width             = self.languageLabel.x + self.languageLabel.width;
        backFrame.size.height            = self.languageLabel.height;
        self.languageLabelBackView.frame = backFrame;
        
    }
    
}

- (void) loadData {
    
    UserInfomationModel *model = self.data;
    
    self.titleLabel.text = @"擅长语言：";
    [self.titleLabel sizeToFit];
    
    if (!model.image) {
        
        //  下载头像
        NSString *downloudImageUrlStr = model.avatar_url;
        NSURL    *downloudImageUrl    = [NSURL URLWithString:downloudImageUrlStr];
        
        [DownloadImage downloadImageForImageView:self.iconImageView
                                        imageUrl:downloudImageUrl
                                placeholderImage:@"github_icon"
                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                            
                                        }
                                         success:^(UIImage *finishImage) {
                                             
                                         }];
        
    } else {
        
        self.iconImageView.image = model.image;
        
    }
    
    //  更新昵称label
    self.nameLabel.text = model.name;
    
    //  更新语言label
    self.languageLabel.text = model.language;
    
    //   刷新UI
    {
        
        CGRect frame   = self.languageLabel.frame;
        frame.origin.x = self.titleLabel.x + self.titleLabel.width;
        
        CGSize size       = [self sizeWithString:self.languageLabel.text
                                            font:self.languageLabel.font
                                           width:Width - self.languageLabelBackView.x - frame.origin.x - 10];
        frame.size.width  = size.width;
        frame.size.height = size.height;
        self.languageLabel.frame = frame;
        
        CGRect backFrame                 = self.languageLabelBackView.frame;
        backFrame.size.width             = self.languageLabel.x + self.languageLabel.width;
        backFrame.size.height            = self.languageLabel.height;
        self.languageLabelBackView.frame = backFrame;
        
    }
    
}

- (void) getNetWorkingData; {
    
    UserInfomationModel *model = self.data;
    
    if (model.url.length > 0) {
        
        [_delegate getUserNameInformationUrlWithUrlString:model.url withTag:model.tag];
        
    } else {
        
        //  更新昵称label
        self.nameLabel.text = model.login;
        
    }
    
    if (model.repos_url.length > 0) {
        
        [_delegate getUserLanguageInformationUrlWithUrlString:model.repos_url withTag:model.tag];
        
    }
    
}

//  计算label高度
- (CGSize) sizeWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 900)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName : font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

@end
