//
//  StoriesContentModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/2.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoriesContentModel : JSONModel

@property (nonatomic, copy)NSString* share_url;

@end

@interface StoriesExtraContentModel : JSONModel

@property (nonatomic, assign)NSInteger long_comments;
@property (nonatomic, assign)NSInteger popularity;
@property (nonatomic, assign)NSInteger short_comments;
@property (nonatomic, assign)NSInteger comments;

@end

NS_ASSUME_NONNULL_END
