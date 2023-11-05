//
//  NavigationModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import "NavigationModel.h"

@implementation NavigationModel

+ (NSString *)getTitle {
    NSDate* currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components: NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate: currentDate];
    NSInteger hour = [components hour];
    
    NSString* titleModel = [[NSString alloc] init];
    if (hour > 18 && hour < 22) {
        titleModel = @"晚上好!";
    } else if (hour < 9) {
        titleModel = @"早上好!";
    } else if (hour >= 22) {
        titleModel = @"早点睡~";
    } else {
        titleModel = @"知乎日报";
    }
    
    return titleModel;
}

+ (NSString *)getAvatarString {
    return @"灰太狼.png";
}

@end
