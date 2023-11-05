//
//  LatestStoriesModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Stories
@end

@protocol Top_Stories
@end


@interface Stories : JSONModel

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* hint;

@end

@interface Top_Stories : JSONModel

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* hint;
 
@end

@interface LatestStoriesModel : JSONModel

@property (nonatomic, copy) NSString* date;
@property (nonatomic, copy) NSArray<Stories>* stories;
@property (nonatomic, copy) NSArray<Top_Stories>* top_stories;

@end

NS_ASSUME_NONNULL_END
