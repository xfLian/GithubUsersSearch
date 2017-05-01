//
//  LanguageRootModel.h
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageRootModel : NSObject

@property (nonatomic, strong) NSArray *languageArray;

- (instancetype)initWithArray:(NSArray *)array;

- (NSString *) getMostUseLanguageMessageWithArray:(NSArray *)languageArray;

@end
