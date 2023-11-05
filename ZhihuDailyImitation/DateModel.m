//
//  DateModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import "DateModel.h"

@implementation DateModel

///类方法是对外公开的接口
/*
 在 Objective-C 中，类方法是通过类本身来调用的，并且类方法是对外公开的接口。私有方法是指只能在类的实现文件（.m 文件）中调用的方法，而不能在类的外部或其他类中直接调用。

 当你在类方法中尝试调用当前类的私有方法时，Xcode会发出警告或错误，因为类方法是通过类名而不是实例来调用的。私有方法针对实例对象而不是类本身进行定义和使用，因此在类方法中无法直接访问或调用私有方法。

 为了解决这个问题，你可以考虑将私有方法转换为类方法或将其移到类的公共接口中。这样其他类和类方法就可以直接调用它们了。另一种选择是通过在类方法中创建实例对象，然后调用实例方法的方式来间接调用私有方法。

 重要的是要记住，封装是面向对象编程的核心概念之一，私有方法的存在是为了将实现细节隐藏起来，提供清晰的公共接口。直接在类方法中调用私有方法可能会破坏封装的原则，导致代码的可维护性和可理解性降低。

 希望这能解答你的疑问！🙂

 在 Objective-C 中，关键字 `self` 在不同的上下文中具有不同的含义。

 1. 在实例方法中，`self` 指代当前的实例对象，可以用来访问实例变量和调用实例方法。

 2. 在类方法中，`self` 指代当前的类对象，可以用来调用其他类方法或访问类变量。因为类方法是通过类本身来调用的，所以在类方法中的 `self` 实际上指向该类本身。

 总结起来，`self` 的值取决于当前上下文。在实例方法中，它指代当前实例对象；在类方法中，它指代当前的类对象。

 请注意，类对象是一个特殊的实例，用于表示类本身。通过类对象可以访问类方法和类变量。每个类只有一个类对象。

 希望这解答了你的疑问！🙂

 */

+ (NSTimeInterval)getTimestampWithTimeString: (NSString *)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"YYYYMMdd"];
    
    NSDate* date = [dateFormatter dateFromString: timeString];
    
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    return timeStamp;
}

+ (NSString *)getMonthWithTimeString:(nonnull NSString *)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM"];
    
    //这里面self指的就是当前类 而不是实例 因此get时间戳方法不能作为实例
    NSTimeInterval timeStamp = [self getTimestampWithTimeString: timeString];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: timeStamp];
    
    NSString* monthString = [dateFormatter stringFromDate: date];
    
    NSInteger monthIndex = [monthString integerValue] - 1;
    NSArray* monthArray = [[NSArray alloc] initWithObjects: @"正", @"杏", @"桃", @"槐", @"蒲", @"荷", @"巧", @"桂", @"菊", @"阴", @"辜", @"腊", nil];
    NSString* monthCharacter = [NSString stringWithFormat: @"%@月", monthArray[monthIndex]];
    
    return monthCharacter;
}

+ (NSString *)getDayWithTimeString:(nonnull NSString *)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"dd"];
    
    NSTimeInterval timeStamp = [self getTimestampWithTimeString: timeString];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: timeStamp];
    
    NSString* dayString = [dateFormatter stringFromDate: date];
    
    return dayString;
}

+ (NSString *)getDateWithTimeString:(NSString *)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM月dd日"];
    
    NSTimeInterval timeStamp = [self getTimestampWithTimeString: timeString];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: timeStamp];
    
    NSString* dateString = [dateFormatter stringFromDate: date];
    
    return dateString;
}

+ (NSString *)getBeforeDateWithTimeString:(NSString *)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"YYYYMMdd"];
    
    NSTimeInterval timeStamp = [self getTimestampWithTimeString: timeString];
    timeStamp -= 60 * 60 * 24;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970: timeStamp];
    
    NSString* dayString = [dateFormatter stringFromDate: date];
    
    return dayString;
}



@end
