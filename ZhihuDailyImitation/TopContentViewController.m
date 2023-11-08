//
//  TopContentViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import "TopContentViewController.h"
#import "StoriesContentModel.h"
#import "Manager.h"

@interface TopContentViewController ()

@end

@implementation TopContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.topContentView = [[TopContentView alloc] initWithFrame: self.view.bounds];
    [self setTopContentViewAndModel];
    
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.toolbar setBarStyle: UIBarStyleDefault];
    self.navigationController.toolbar.backgroundColor = [UIColor whiteColor];

    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(scrollNext:) name: @"scrollViewDidEndDecelerating" object: nil];
}

#pragma mark 可滑动切换Web
- (void)setTopContentViewAndModel {
    self.topContentView.numberOfStories = [self.contentModel.storiesIDArray count];
    self.topContentView.currentPage = self.currentPage;
    [self.topContentView setUI];
    
    
    [[Manager sharedManager] requestWebContentWithID: self.contentModel.storiesIDArray[self.currentPage - 1] StoriesContentData:^(StoriesContentModel * _Nonnull storiesContentModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.topContentView setNextWebImageWithString: storiesContentModel.share_url andIndex: self.currentPage - 1];
        });
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求网页内容失败");
    }];
    
    [[Manager sharedManager] requestExtraContentWithID: self.contentModel.storiesIDArray[self.currentPage - 1] StoriesExtraContentData:^(StoriesExtraContentModel * _Nonnull storiesExtraContentModel) {
            [self.contentModel.storiesExtraContentDictionary setObject: storiesExtraContentModel forKey: self.contentModel.storiesIDArray[self.currentPage - 1]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setToolBar];
            });
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求额外消息失败");
        }];
    [self.view addSubview: self.topContentView];
}

- (void)scrollNext: (NSNotification *)notification {
    self.currentPage = [notification.userInfo[@"value"] intValue] + 1;
    if ([self.topContentView.currentWebViewSet containsObject: notification.userInfo[@"value"]]) {
        [self setToolBar];
        return;
    }
    
    [[Manager sharedManager] requestExtraContentWithID: self.contentModel.storiesIDArray[self.currentPage - 1] StoriesExtraContentData:^(StoriesExtraContentModel * _Nonnull storiesExtraContentModel) {
                [self.contentModel.storiesExtraContentDictionary setObject: storiesExtraContentModel forKey: self.contentModel.storiesIDArray[self.currentPage - 1]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setToolBar];
                });
            } failure:^(NSError * _Nonnull error) {
                NSLog(@"请求下一页额外消息失败");
            }];
        
        [[Manager sharedManager] requestWebContentWithID: self.contentModel.storiesIDArray[self.currentPage - 1] StoriesContentData:^(StoriesContentModel * _Nonnull storiesContentModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.topContentView setNextWebImageWithString: storiesContentModel.share_url andIndex: self.currentPage - 1];
            });
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求下一页网页内容失败");
        }];
}

#pragma mark 设置工具栏———————————
- (void)setToolBar {
    StoriesExtraContentModel* storiesExtraContentModel = self.contentModel.storiesExtraContentDictionary[self.contentModel.storiesIDArray[self.currentPage - 1]];
    
    if (!self.backItem) {
        UIBarButtonItem* flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        
        UIView* backView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIButton* backButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [backButton setImage: [UIImage imageNamed:@"back.png"] forState: UIControlStateNormal];
        [backButton addTarget: self action: @selector(pressBack) forControlEvents: UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0, 0, 50, 50);
        [backView addSubview: backButton];
        self.backItem = [[UIBarButtonItem alloc] initWithCustomView: backView];
        
        UIView* grayView = [[UIView alloc] initWithFrame: CGRectMake(35, 22, 1, 35)];
        grayView.backgroundColor = [UIColor lightGrayColor];
        self.grayItem = [[UIBarButtonItem alloc] initWithCustomView: grayView];
        
        UIView* commentView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIButton* commentButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [commentButton setImage: [UIImage imageNamed: @"comment.png"] forState: UIControlStateNormal];
        [commentButton addTarget: self action: @selector(pressComment) forControlEvents: UIControlEventTouchUpInside];
        commentButton.frame = CGRectMake(0, 0, 50, 50);
        [commentView addSubview: commentButton];
        self.commentLabel = [[UILabel alloc] initWithFrame: CGRectMake(41, 0, 30, 20)];
        self.commentLabel.font = [UIFont systemFontOfSize: 14];
        [commentView addSubview: self.commentLabel];
        self.commentItem = [[UIBarButtonItem alloc] initWithCustomView: commentView];
        
        UIView* likeView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIButton* likeButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [likeButton setImage: [UIImage imageNamed: @"like.png"] forState: UIControlStateNormal];
        [likeButton addTarget: self action: @selector(pressLike:) forControlEvents: UIControlEventTouchUpInside];
        likeButton.frame = CGRectMake(0, 0, 50, 50);
        self.likeButton = likeButton;
        [likeView addSubview: self.likeButton];
        self.likeLabel = [[UILabel alloc] initWithFrame: CGRectMake(41, 0, 30, 20)];
        self.likeLabel.font = [UIFont systemFontOfSize: 14];
        [likeView addSubview: self.likeLabel];
        self.likeItem = [[UIBarButtonItem alloc] initWithCustomView: likeView];
        
        UIView* collectView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIButton* collectButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [collectButton setImage: [UIImage imageNamed: @"collect.png"] forState: UIControlStateNormal];
        [collectButton addTarget: self action: @selector(pressCollect:) forControlEvents: UIControlEventTouchUpInside];
        collectButton.frame = CGRectMake(0, 0, 50, 50);
        self.collectButton = collectButton;
        [collectView addSubview: self.collectButton];
        self.collectItem = [[UIBarButtonItem alloc] initWithCustomView: collectView];
        
        UIView* shareView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        UIButton* shareButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [shareButton setImage: [UIImage imageNamed: @"share.png"] forState: UIControlStateNormal];
        [shareButton addTarget: self action: @selector(pressShare) forControlEvents: UIControlEventTouchUpInside];
        shareButton.frame = CGRectMake(0, 0, 50, 50);
        [shareView addSubview: shareButton];
        self.shareItem = [[UIBarButtonItem alloc] initWithCustomView: shareView];
        
        NSArray* array = [NSArray arrayWithObjects: self.backItem, self.grayItem, flexible, self.commentItem, flexible, self.likeItem, flexible, self.collectItem, flexible, self.shareItem, nil];
        self.toolbarItems = array;
    }
    
    if ([self.contentModel.storiesLikeSet containsObject: self.contentModel.storiesIDArray[self.currentPage - 1]]) {
        [self.likeButton setImage: [UIImage imageNamed: @"liked.png"] forState: UIControlStateNormal];
        self.likeLabel.text = [NSString stringWithFormat: @"%ld", storiesExtraContentModel.popularity + 1];
    } else {
        [self.likeButton setImage: [UIImage imageNamed: @"like.png"] forState: UIControlStateNormal];
        self.likeLabel.text = [NSString stringWithFormat: @"%ld", storiesExtraContentModel.popularity];
        NSLog(@"%ld", storiesExtraContentModel.popularity);
    }
    
    if ([self.contentModel.storiesCollectSet containsObject: self.contentModel.storiesIDArray[self.currentPage - 1]]) {
        [self.collectButton setImage: [UIImage imageNamed: @"collected.png"] forState: UIControlStateNormal];
    } else {
        [self.collectButton setImage: [UIImage imageNamed:@"collect.png"] forState: UIControlStateNormal];
    }
    
    self.commentLabel.text = [NSString stringWithFormat: @"%ld", storiesExtraContentModel.comments];
}

- (void) pressBack {
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)pressComment {
    NSLog(@"pressedComment");
}

- (void)pressLike:(UIButton*)sender {
    if ([self.contentModel.storiesLikeSet containsObject: self.contentModel.storiesIDArray[self.currentPage - 1]]) {
        [self.contentModel.storiesLikeSet removeObject: self.contentModel.storiesIDArray[self.currentPage - 1]];
        [sender setImage: [UIImage imageNamed: @"like.png"] forState: UIControlStateNormal];
        [self.contentModel deleteLikeSetWithID: self.contentModel.storiesIDArray[self.currentPage - 1]];
        
        self.likeLabel.text = [NSString stringWithFormat: @"%ld", [self.likeLabel.text integerValue] - 1];
    } else {
        [sender setImage: [UIImage imageNamed: @"liked.png"] forState: UIControlStateNormal];
        [self.contentModel.storiesLikeSet addObject: self.contentModel.storiesIDArray[self.currentPage - 1]];
        [self.contentModel saveStoriesLikeSet];
        
        self.likeLabel.text = [NSString stringWithFormat: @"%ld", [self.likeLabel.text integerValue] + 1];
    }
}

- (void)pressCollect:(UIButton*)sender {
    if ([self.contentModel.storiesCollectSet containsObject: self.contentModel.storiesIDArray[self.currentPage - 1]]) {
        [self.contentModel.storiesCollectSet removeObject: self.contentModel.storiesIDArray[self.currentPage - 1]];
        [sender setImage: [UIImage imageNamed: @"collect.png"] forState: UIControlStateNormal];
        [self.contentModel deleteCollectSetWithID: self.contentModel.storiesIDArray[self.currentPage - 1]];
    } else {
        [self.contentModel.storiesCollectSet addObject: self.contentModel.storiesIDArray[self.currentPage - 1]];
        [sender setImage: [UIImage imageNamed: @"collected.png"] forState: UIControlStateNormal];
        [self.contentModel saveStoriesCollectSet];
    }
}

- (void) pressShare {
    NSLog(@"pressedShare");
}
#pragma mark 设置工具栏———————————


- (void)initStoriesModel {
    if (!self.contentModel) {
        self.contentModel = [[ContentModel alloc] init];
    }
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
