//
//  TopContentView.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import <UIKit/UIKit.h>
#import "WebKit/WebKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopContentView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView* scrollView;
@property (nonatomic, assign)NSInteger offSetX;

@property (nonatomic, assign)NSInteger numberOfStories;
@property (nonatomic, assign)NSInteger currentPage;

@property (nonatomic, strong)NSMutableSet* currentWebViewSet;
@property (nonatomic, strong)WKWebView* nextWebView;

- (void)setUI;
- (void)setNextWebImageWithString: (NSString*)string andIndex: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
