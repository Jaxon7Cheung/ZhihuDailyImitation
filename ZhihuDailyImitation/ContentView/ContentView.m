//
//  ContentView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/5.
//

#import "ContentView.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ContentView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x == Screen_WIDTH * self.numberOfStories) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"upDateRight" object: nil];
        return;
    }
    
    NSInteger index = self.scrollView.contentOffset.x / Screen_WIDTH;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"scrollViewDidEndDecelerating" object: nil userInfo: @{@"value" : [NSNumber numberWithInteger: index]}];
    
    if (self.scrollView.contentOffset.x == Screen_WIDTH * (self.numberOfStories - 1)) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + Screen_WIDTH, 0);
    }
}


- (void)upDateRightWebView {
    self.scrollView.contentSize = CGSizeMake(Screen_WIDTH * self.numberOfStories, 0);
    
    NSInteger index = self.scrollView.contentOffset.x / Screen_WIDTH;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"scrollViewDidEndDecelerating" object: nil userInfo: @{@"value" : [NSNumber numberWithInteger: index]}];
    
    if (self.scrollView.contentOffset.x == Screen_WIDTH * (self.numberOfStories - 1)) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + Screen_WIDTH, 0);
    }
}

- (void)setNextWebImageWithString:(NSString *)string andIndex:(NSInteger)index {
    if ([self.currentWebViewSet containsObject: [NSNumber numberWithInteger: index]]) return;
    
    self.nextWebView = [[WKWebView alloc] initWithFrame: CGRectMake(Screen_WIDTH * index, 0, Screen_WIDTH, Screen_HEIGHT - 165)];
    [[Manager sharedManager] setWebView: self.nextWebView WithString: string];
    [self.scrollView addSubview: self.nextWebView];
    
    [self.currentWebViewSet addObject: [NSNumber numberWithInteger: index]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
