//
//  TopStoriesCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import "TopStoriesCell.h"
#import <CoreImage/CoreImage.h>
#define Screen_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CellHeight [UIScreen mainScreen].bounds.size.height / 8.5

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation TopStoriesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self.contentView addSubview: self.scrollView];
        
        self.pageController = [[UIPageControl alloc] init];
        self.pageController.numberOfPages = 5;
        [self.contentView addSubview: self.pageController];
        
        [self createTimer];
    }
    return self;
}

- (void)layoutSubviews {
    self.scrollView.frame = CGRectMake(0, 0, Screen_WIDTH, CellHeight * 3.5);
    self.scrollView.contentSize = CGSizeMake(Screen_WIDTH * 7, CellHeight * 3.5);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.userInteractionEnabled = YES;
    self.pageController.currentPage = 0;
    for (int i = 0; i < 7; i++) {
        UIImageView* imageView = self.imageViewArray[i];
        //imageView.image = [self coreBlurImage: imageView.image withBlurNumber: 55];
        imageView.frame = CGRectMake(Screen_WIDTH * i, 0, Screen_WIDTH, CellHeight * 3.5);
        [self.scrollView addSubview: imageView];
        
        UILabel* titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize: 25];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 2;
        
        titleLabel.frame = CGRectMake(15, CellHeight * 2, Screen_WIDTH - 15, CellHeight);
        [imageView addSubview: titleLabel];
//        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(CellHeight);
//            make.bottom.equalTo(imageView.bottom).offset(37);
//            make.width.equalTo(Screen_WIDTH).offset(37);
//        }];
        
        if (i > 0 && i < 6) {
            titleLabel.text = self.titleArray[i - 1];
        } else if (i == 0) {
            titleLabel.text = self.titleArray[4];
        } else if (i == 6) {
            titleLabel.text = self.titleArray[0];
        }
        
        UILabel* userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont systemFontOfSize: 16];
        userNameLabel.textColor = [UIColor colorWithRed: 220.0 / 255 green: 220.0 / 255 blue: 220.0 / 255 alpha: 0.8];
        userNameLabel.numberOfLines = 2;
        
        userNameLabel.frame = CGRectMake(15, CellHeight * 2.7 + CellHeight / 5, Screen_WIDTH - 15, CellHeight / 2);
        [imageView addSubview:userNameLabel];
        
//        [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(CellHeight / 2);
//            make.bottom.equalTo(imageView.bottom);
//            make.width.equalTo(Screen_WIDTH);
//        }];
        
        if (i > 0 && i < 6) {
            userNameLabel.text = self.userNameArray[i - 1];
        } else if (i == 0) {
            userNameLabel.text = self.userNameArray[4];
        } else if (i == 6) {
            userNameLabel.text = self.userNameArray[0];
        }
        
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer: tap];
    }
  
    self.scrollView.contentOffset = CGPointMake(Screen_WIDTH, 0);
    
    [self.pageController makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(20);
        make.bottom.equalTo(-10);
    }];
    
//    NSLog(@"%@", self.imageViewArray);
//    NSLog(@"%@", self.titleArray);
//    NSLog(@"%@", self.userNameArray);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.preOffsetx = self.scrollView.contentOffset.x;
    
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat leftOffsetx = 0;
    CGFloat rightOffsetx = Screen_WIDTH * 6;
    
    if (self.scrollView.contentOffset.x > self.preOffsetx) {
        // 右移
        if (self.scrollView.contentOffset.x >= rightOffsetx) {
            self.scrollView.contentOffset = CGPointMake(Screen_WIDTH, 0);
            self.pageController.currentPage = 0;
        }
        
        if (self.scrollView.contentOffset.x < rightOffsetx) {
            self.pageController.currentPage = self.scrollView.contentOffset.x / Screen_WIDTH - 1;
        }
        
    } else if (self.scrollView.contentOffset.x < self.preOffsetx) {
        // 左移
        if (self.scrollView.contentOffset.x <= leftOffsetx) {
            self.scrollView.contentOffset = CGPointMake(Screen_WIDTH * 5, 0);
            self.pageController.currentPage = 4;
        }
        if (self.scrollView.contentOffset.x > leftOffsetx) {
            self.pageController.currentPage = self.scrollView.contentOffset.x / Screen_WIDTH - 1;
        }
    }
    
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];
}


- (void) createTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pageRight) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void) pageRight {
    CGFloat rightOffsetx = Screen_WIDTH * 6;
    CGFloat OffsetX = self.scrollView.contentOffset.x + Screen_WIDTH;
    
    if (OffsetX >= rightOffsetx) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        OffsetX = Screen_WIDTH;
    }
    
    [self.scrollView setContentOffset: CGPointMake(OffsetX , 0) animated:  YES];
    if (OffsetX < rightOffsetx) {
        self.pageController.currentPage = OffsetX / Screen_WIDTH - 1;
    } else if (OffsetX == rightOffsetx) {
        self.pageController.currentPage = 0;
    }
}

//- (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
//{
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
//    //设置filter
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
//    //模糊图片
//    CIImage *result=[filter valueForKey:kCIOutputImageKey];
//    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
//    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
//    CGImageRelease(outImage);
//    return blurImage;
//}

- (void)pressTap:(UITapGestureRecognizer*)tap {
    NSNumber* index = [NSNumber numberWithInteger: self.pageController.currentPage];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"top_stories" object: nil userInfo: @{@"value" : index}];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
