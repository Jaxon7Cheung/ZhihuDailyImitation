//
//  CommentModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/12.
//

#import "CommentModel.h"

@implementation Reply_To

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end


@implementation Comments

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation CommentModel

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
