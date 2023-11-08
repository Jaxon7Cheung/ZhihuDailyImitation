//
//  MainViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import "MainViewController.h"

#import "DateModel.h"
#import "NavigationModel.h"
#import "StoriesModel.h"

#import "PersonViewController.h"
#import "TopContentViewController.h"
#import "ContentViewController.h"

#import "TopContentView.h"
#import "ContentView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: YES animated: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [Manager sharedManager];
    [self.manager requestTopStoriesData:^(LatestStoriesModel * _Nonnull latestStoriesModel) {
        self.latestStoriesModel = latestStoriesModel;
        
        self.mainView = [[MainView alloc] initWithFrame: self.view.bounds];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self sendViewStories: latestStoriesModel];
            [self createTopImages];
            [self setViewAndModel];
            [self requestBeforeStoriesWithDate: self.latestStoriesModel.date];
            
        });
        
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"最新消息请求失败");
        }];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(loadBeforeStories) name: @"loadBeforeStories" object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(getTopStoriesTapPage:) name: @"top_stories" object: nil];
    
    //更新首页
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(upDateRight) name: @"upDateRight" object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressStoriesCell:) name: @"pressStoriesCell" object: nil];
    
}


#pragma mark 首页接收Content页通知更新
- (void) upDateRight {
    StoriesModel* storiesModel = [self.beforeStoriesModelArray lastObject];
    NSString* beforeDate = storiesModel.date;
    [self requestBeforeStoriesWithDate: beforeDate];
}

- (void)setViewAndModel {
    [self.view addSubview: self.mainView];
    [self.mainView setMainUI];
    self.mainView.monthLabel.text = [DateModel getMonthWithTimeString: self.latestStoriesModel.date];
//    NSLog(@"%@", self.latestStoriesModel.date);
    self.mainView.dayLabel.text = [DateModel getDayWithTimeString: self.latestStoriesModel.date];
    self.mainView.titleLabel.text = [NavigationModel getTitle];
    
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(pushPersonViewController)];
    [self.mainView.avatar addGestureRecognizer: tapGestureRecognizer];
}

- (void)sendViewStories: (JSONModel *)storiesModel {
    if (!self.mainView.storiesArray) {
        self.mainView.storiesArray = [[NSMutableArray alloc] init];
    }
    if (!self.mainView.beforeDateArray) {
        self.mainView.beforeDateArray = [[NSMutableArray alloc] init];
    }
    
    NSDictionary* dict = [storiesModel toDictionary];
    [self.mainView.storiesArray addObject: dict[@"stories"]];
    [self.mainView.beforeDateArray addObject: dict[@"date"]];
}

- (void)requestBeforeStoriesWithDate: (NSString *)date {
    [self.manager requestBeforeDate: date beforeStoriesData:^(StoriesModel * _Nonnull beforeStoriesModel) {
            if (!self.beforeStoriesModelArray) {
                self.beforeStoriesModelArray = [[NSMutableArray alloc] init];
            }
            [self.beforeStoriesModelArray addObject: beforeStoriesModel];
        //NSLog(@"%@", beforeStoriesModel.date);

        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendViewStories: beforeStoriesModel];
            self.mainView.isLoading = NO;
            [self.mainView.tableView reloadData];

            NSMutableArray* storiesArray = [[NSMutableArray alloc] init];
            for (Stories* stories in beforeStoriesModel.stories) {
                [storiesArray addObject: stories.id];
            }
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"upDateRight-Two" object:nil userInfo: @{@"value" : storiesArray}];
        });
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求过往消息失败");
        }];
}

- (void)loadBeforeStories {
    StoriesModel* storiesModel = [self.beforeStoriesModelArray lastObject];
    //NSLog(@"%@", storiesModel);
    
    NSString* foreDate = storiesModel.date;
    //NSLog(@"%@", foreDate);
    [self.manager requestBeforeDate: foreDate beforeStoriesData:^(StoriesModel * _Nonnull beforeStoriesModel) {
            [self.beforeStoriesModelArray addObject: beforeStoriesModel];
            [self sendViewStories: beforeStoriesModel];
            
        NSString* foreForeDate = [DateModel getBeforeDateWithTimeString: foreDate];
        [self.manager requestBeforeDate: foreForeDate beforeStoriesData:^(StoriesModel * _Nonnull beforeStoriesModel) {
                    [self.beforeStoriesModelArray addObject: beforeStoriesModel];
                    [self sendViewStories: beforeStoriesModel];
            
            NSString* foreForeForeDate = [DateModel getBeforeDateWithTimeString: foreForeDate];
            [self.manager requestBeforeDate: foreForeForeDate beforeStoriesData:^(StoriesModel * _Nonnull beforeStoriesModel) {
                            [self.beforeStoriesModelArray addObject: beforeStoriesModel];
                            [self sendViewStories: beforeStoriesModel];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.mainView.isLoading = NO;
                                [self.mainView.tableView reloadData];
                            });
                        } failure:^(NSError * _Nonnull error) {
                            NSLog(@"请求大前天消息失败");
                        }];
                } failure:^(NSError * _Nonnull error) {
                    NSLog(@"请求前天消息失败");
                }];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求昨天消息失败");
        }];
}

#pragma mark 个人界面
- (void)pushPersonViewController {
    PersonViewController* personViewController = [[PersonViewController alloc] init];
    [self.navigationController pushViewController: personViewController animated: YES];
}

#pragma mark 轮播图
- (void) createTopImages {
    self.imageViewArray = [[NSMutableArray alloc] init];
    self.topTitleArray = [[NSMutableArray alloc] init];
    self.topUserNameArray = [[NSMutableArray alloc] init];
    
    UIImageView* firstImageView = [[UIImageView alloc] init];
    Top_Stories* top_storie = self.latestStoriesModel.top_stories[4];
    [Manager setImage: firstImageView WithString: top_storie.image];
    [self.imageViewArray addObject: firstImageView];
    
    for (Top_Stories* top_storie in self.latestStoriesModel.top_stories) {
        UIImageView* imageView = [[UIImageView alloc] init];
        
        [Manager setImage: imageView WithString: top_storie.image];
        
        [self.imageViewArray addObject: imageView];
        
        [self.topTitleArray addObject: top_storie.title];
        [self.topUserNameArray addObject: top_storie.hint];
        
    }
    
    UIImageView* lastImageView = [[UIImageView alloc] init];
    top_storie = self.latestStoriesModel.top_stories[0];
    [Manager setImage: lastImageView WithString: top_storie.image];
    [self.imageViewArray addObject: lastImageView];
    
    self.mainView.imageViewArray = self.imageViewArray;
    self.mainView.topTitleArray = self.topTitleArray;
    self.mainView.topUserNameArray = self.topUserNameArray;
    
}

#pragma mark 推入TOPStories内容
- (void)getTopStoriesTapPage: (NSNotification*)notification {
    NSDictionary* dict = notification.userInfo;
    NSInteger index = [dict[@"value"] integerValue];
    
    Top_Stories* top_stories = self.latestStoriesModel.top_stories[index];
    
    [self pushTopContentViewControllerWhithID: top_stories.id andIndex: index];
}

- (void)pushTopContentViewControllerWhithID: (NSString*)id andIndex: (NSInteger)index {
    
    TopContentViewController* topContentViewController = [[TopContentViewController alloc] init];
    [topContentViewController initStoriesModel];
    
    topContentViewController.contentModel.storiesIDArray = [[NSMutableArray alloc] init];
    for (Top_Stories* stories in self.latestStoriesModel.top_stories) {
        [topContentViewController.contentModel.storiesIDArray addObject: stories.id];
    }
    topContentViewController.currentPage = index + 1;
    topContentViewController.topContentView = [[TopContentView alloc] initWithFrame: self.view.bounds];
    
    [self.navigationController pushViewController: topContentViewController animated:YES];
}

#pragma mark 推入Stories内容

- (void)pressStoriesCell:(NSNotification*)notification {
    NSInteger index = [notification.userInfo[@"value"] integerValue];
    
    [self pushContentViewControllerWithIndex: index];
}

- (void)pushContentViewControllerWithIndex: (NSInteger)index {
    ContentViewController* contentViewController = [[ContentViewController alloc] init];
    
    [contentViewController initStoriesModel];
    
    contentViewController.contentModel.storiesIDArray = [[NSMutableArray alloc] init];
    
    for (Stories* stories in self.latestStoriesModel.stories) {
        [contentViewController.contentModel.storiesIDArray addObject: stories.id];
    }
    
    for (StoriesModel* storiesModel in self.beforeStoriesModelArray) {
        for (Stories* stories in storiesModel.stories) {
            [contentViewController.contentModel.storiesIDArray addObject: stories.id];
        }
    }
    
    contentViewController.currentPage = index + 1;
    contentViewController.topContentView = [[ContentView alloc] initWithFrame: self.view.bounds];
    
    [self.navigationController pushViewController: contentViewController animated: YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
