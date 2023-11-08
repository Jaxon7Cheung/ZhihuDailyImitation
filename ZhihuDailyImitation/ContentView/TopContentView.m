//
//  TopContentView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import "TopContentView.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "Manager.h"


@implementation TopContentView

- (void)setUI {
    self.currentWebViewSet = [[NSMutableSet alloc] init];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame: self.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(Screen_WIDTH * self.numberOfStories, 0);
    self.scrollView.contentOffset = CGPointMake(Screen_WIDTH * (self.currentPage - 1), 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.delegate = self;
    [self addSubview: self.scrollView];
}

- (void)setNextWebImageWithString:(NSString *)string andIndex:(NSInteger)index {
    if ([self.currentWebViewSet containsObject: [NSNumber numberWithInteger: index]]) return;
    
    self.nextWebView = [[WKWebView alloc] initWithFrame: CGRectMake(Screen_WIDTH * index, 0, Screen_WIDTH, Screen_HEIGHT - 165)];
    [[Manager sharedManager] setWebView: self.nextWebView WithString: string];
    [self.scrollView addSubview: self.nextWebView];
    
    [self.currentWebViewSet addObject: [NSNumber numberWithInteger: index]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = self.scrollView.contentOffset.x / Screen_WIDTH;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"scrollViewDidEndDecelerating" object: nil userInfo: @{@"value" : [NSNumber numberWithInteger: index]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
