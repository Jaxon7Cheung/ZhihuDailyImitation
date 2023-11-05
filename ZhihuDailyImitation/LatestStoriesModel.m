//
//  LatestStoriesModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import "LatestStoriesModel.h"

@implementation LatestStoriesModel

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;;
}

@end

@implementation Stories

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation Top_Stories

+ (BOOL) propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
