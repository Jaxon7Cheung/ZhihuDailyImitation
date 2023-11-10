//
//  Manager.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import <Foundation/Foundation.h>
#import "LatestStoriesModel.h"
#import "StoriesModel.h"
#import "WebKit/WebKit.h"
#import "StoriesContentModel.h"
#import "CollectionContentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LatestStoriesBlock)(LatestStoriesModel* latestStoriesModel);
typedef void(^BeforeStoriesModelBlock)(StoriesModel* beforeStoriesModel);
typedef void(^StoriesContentBlock)(StoriesContentModel* storiesContentModel);
typedef void(^StoriesExtraContentBlock)(StoriesExtraContentModel* storiesExtraContentModel);
typedef void(^CollectionContentBlock)(CollectionContentModel* collectionContentModel);
typedef void(^ErrorBlock)(NSError* error);

@interface Manager : NSObject

+ (instancetype)sharedManager;

- (void)requestTopStoriesData: (LatestStoriesBlock)success failure: (ErrorBlock)failure;

+ (void)setImage: (id)imageView WithString: (NSString *)string;

- (void)requestBeforeDate: (NSString *)date beforeStoriesData: (BeforeStoriesModelBlock)success failure: (ErrorBlock)failure;

- (void)setWebView: (WKWebView *)webView WithString: (NSString *)string;

- (void)requestWebContentWithID: (NSString *)string StoriesContentData: (StoriesContentBlock)success failure: (ErrorBlock)failure;

- (void)requestExtraContentWithID: (NSString *)string StoriesExtraContentData: (StoriesExtraContentBlock)success failure: (ErrorBlock)failure;

- (void)requestCollectionContentWithID: (NSString *)string CollectionContentData: (CollectionContentBlock)success failure: (ErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
