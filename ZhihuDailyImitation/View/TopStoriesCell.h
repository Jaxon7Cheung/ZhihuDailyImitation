//
//  TopStoriesCell.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopStoriesCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView* scrollView;

@property (nonatomic, strong)NSMutableArray* imageViewArray;
@property (nonatomic, strong)NSMutableArray* titleArray;
@property (nonatomic, strong)NSMutableArray* userNameArray;

@property (nonatomic, strong)UIPageControl* pageController;
@property (nonatomic, assign)CGFloat preOffsetx;

@property (nonatomic, strong)NSTimer* timer;

//- (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
