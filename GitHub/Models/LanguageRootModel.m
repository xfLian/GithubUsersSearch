//
//  LanguageRootModel.m
//  GitHub
//
//  Created by xf_Lian on 2017/4/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "LanguageRootModel.h"

@implementation LanguageRootModel

- (instancetype)initWithArray:(NSArray *)array; {
    
    if ([array isKindOfClass:[NSArray class]]) {
        
        if (self = [super init]) {
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            for (NSDictionary *dictionary in array) {
                
                NSString *language = [dictionary objectForKey:@"language"];
                
                if ([language isKindOfClass:[NSNull class]]) {
                    
                    
                } else {
                
                    [tmpArray addObject:language];
                
                }
                
            }
            
            self.languageArray = [tmpArray copy];
            
        }
        
    }
    
    return self;
}

- (NSString *) getMostUseLanguageMessageWithArray:(NSArray *)languageArray; {

    NSString *mostUseLanguageMessage = nil;
    
    NSMutableDictionary *languageDic = [[NSMutableDictionary alloc] init];
    NSMutableArray      *valueArray  = [NSMutableArray array];
    
    for (NSString *language in languageArray) {
        
        NSString *value = [languageDic valueForKey:language];
        if ([value intValue] >= 0) {
            
            int i = [value intValue];
            i ++;
            NSString *tmpValue = [NSString stringWithFormat:@"%d",i];
            [languageDic setObject:tmpValue forKey:language];
            
        } else {
            
            NSString *tmpValue = @"0";
            [languageDic setObject:tmpValue forKey:language];
            
        }
        
    }
    
    //得到词典中所有Value值
    NSEnumerator *enumeratorValue = [languageDic objectEnumerator];
    
    //快速枚举遍历所有Value的值
    for (NSObject *object in enumeratorValue) {
        
        [valueArray addObject:object];
        
    }
    
    NSNumber *maxNumber = [valueArray valueForKeyPath:@"@max.floatValue"];
    NSString *tmpValue  = [NSString stringWithFormat:@"%@",maxNumber];
    
    NSArray        *keyArray      = [languageDic allKeys];
    NSMutableArray *languagesArray = [NSMutableArray array];
    
    for (NSString *key in keyArray) {
        
        if ([tmpValue isEqualToString:[languageDic objectForKey:key]]) {
            
            [languagesArray addObject:key];
            
        }
        
    }
    
    for (NSString *language in languagesArray) {
        
        if (mostUseLanguageMessage.length <= 0) {
            
            mostUseLanguageMessage = language;
            
        } else {
            
            mostUseLanguageMessage = [NSString stringWithFormat:@"%@  %@",mostUseLanguageMessage,language];
            
        }
    }
        
    return mostUseLanguageMessage;

}

@end
