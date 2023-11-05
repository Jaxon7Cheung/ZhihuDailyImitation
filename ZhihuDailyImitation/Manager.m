//
//  Manager.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import "Manager.h"
#import "AFNetworking.h"
#import "SDWebImage.h"

@implementation Manager

static id manager = nil;

+ (instancetype)sharedManager {
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[Manager alloc] init];
        });
    }
    
    return manager;
}

- (void)requestTopStoriesData:(LatestStoriesBlock)success failure:(ErrorBlock)failure {
    [[AFHTTPSessionManager manager] GET: @"https://news-at.zhihu.com/api/4/news/latest" parameters: nil headers: nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            LatestStoriesModel* latestStoriesModel = [[LatestStoriesModel alloc] initWithDictionary: responseObject error: nil];
            success(latestStoriesModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)setImage:(UIImageView *)imageView WithString:(NSString *)string {
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* url = [NSURL URLWithString:string];
    
    [imageView sd_setImageWithURL: url placeholderImage: [UIImage imageNamed: @"placeholder.png"]];
}

- (void)requestBeforeDate:(NSString *)date beforeStoriesData:(BeforeStoriesModelBlock)success failure:(ErrorBlock)failure {
    [[AFHTTPSessionManager manager] GET: [NSString stringWithFormat:  @"https://news-at.zhihu.com/api/4/news/before/%@", date] parameters: nil headers: nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            StoriesModel* beforeStoriesModel = [[StoriesModel alloc] initWithDictionary: responseObject error: nil];
            success(beforeStoriesModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)setWebView:(WKWebView *)webView WithString:(NSString *)string {
    
    //NSLog(@"%@", string);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: string]];
    
    [webView loadRequest: request];
}

- (void)requestWebContentWithID:(NSString *)string StoriesContentData:(StoriesContentBlock)success failure:(ErrorBlock)failure {
    [[AFHTTPSessionManager manager] GET: [NSString stringWithFormat:  @"https://news-at.zhihu.com/api/4/news/%@", string] parameters: nil headers: nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            StoriesContentModel* storiesContentModel = [[StoriesContentModel alloc] initWithDictionary: responseObject error: nil];
            success(storiesContentModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestExtraContentWithID:(NSString *)string StoriesExtraContentData:(StoriesExtraContentBlock)success failure:(ErrorBlock)failure {
    [[AFHTTPSessionManager manager] GET: [NSString stringWithFormat:  @"https://news-at.zhihu.com/api/4/story-extra/%@", string] parameters: nil headers: nil progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            StoriesExtraContentModel* storiesExtraContentModel = [[StoriesExtraContentModel alloc] initWithDictionary: responseObject error: nil];
            success(storiesExtraContentModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
