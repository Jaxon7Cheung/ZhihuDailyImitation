//
//  ContentViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/5.
//


#import "ContentViewController.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.topContentView.currentPage == self.topContentView.numberOfStories) {
        self.topContentView.scrollView.contentSize = CGSizeMake(Screen_WIDTH * (self.topContentView.numberOfStories + 1), 0);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(upDateRight:) name: @"upDateRight-Two" object: nil];
}

- (void)upDateRight:(NSNotification*)notification {
    for (NSString* ID in notification.userInfo[@"value"]) {
        [self.contentModel.storiesIDArray addObject: ID];
    }
    
    self.contentView.numberOfStories = [self.contentModel.storiesIDArray count];
    self.contentView.currentPage = self.currentPage;
//    self.topContentView.numberOfStories = [self.contentModel.storiesIDArray count];
//    self.topContentView.currentPage = self.currentPage;
    
//    ContentView* contentView = (ContentView *)self.topContentView;
    self.contentView = (ContentView *)self.topContentView;

    [self.contentView upDateRightWebView];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
