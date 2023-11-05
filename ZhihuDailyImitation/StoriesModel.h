//
//  StoriesModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import <JSONModel/JSONModel.h>
#import "LatestStoriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoriesModel : JSONModel

@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSArray<Stories>* stories;

@end

NS_ASSUME_NONNULL_END
