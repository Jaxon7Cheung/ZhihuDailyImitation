//
//  DateModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateModel : NSObject

+ (NSTimeInterval)getTimestampWithTimeString: (NSString *)timeString;
+ (NSString *)getMonthWithTimeString: (NSString *)timeString;
+ (NSString *)getDayWithTimeString: (NSString *)timeString;
+ (NSString *)getDateWithTimeString: (NSString *)timeString;
+ (NSString *)getBeforeDateWithTimeString: (NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
