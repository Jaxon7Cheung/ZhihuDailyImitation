//
//  CollectionViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "CollectionViewController.h"
#import "Manager.h"
#import "TopContentViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.collectionModel reloadModel];
    //NSLog(@"111");
    
    dispatch_group_t group = dispatch_group_create();
    //NSLog(@"%@", self.collectionModel.collectionSet);
    for (NSString* ID in self.collectionModel.collectionSet) {
        //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_group_enter(group);
        [[Manager sharedManager] requestCollectionContentWithID: ID CollectionContentData:^(CollectionContentModel * _Nonnull collectionContentModel) {
            [self.collectionModel.titleArray addObject: collectionContentModel.title];
            [self.collectionModel.imageMsgArray addObject: collectionContentModel.image];
            dispatch_group_leave(group);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"获取收藏消息失败");
            dispatch_group_leave(group);
        }];
        
    }
    
    
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.collectionView.titleArray = self.collectionModel.titleArray;
            self.collectionView.imageMsgArray = self.collectionModel.imageMsgArray;
            //NSLog(@"%ld", [self.collectionModel.titleArray count]);
            
            [self.collectionView.tableView reloadData];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionModel = [[CollectionModel alloc] init];
    self.collectionView = [[CollectionView alloc] initWithFrame: self.view.bounds];
    
    [self.view addSubview: self.collectionView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressBack) name: @"pressBack-TWO" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressCollectionCell:) name: @"pressCollectionCell" object: nil];
}

- (void)pressBack {
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)pressCollectionCell: (NSNotification *)notification {
    NSNumber* number = notification.userInfo[@"value"];
    NSInteger index = [number integerValue];
    
    TopContentViewController* topContentViewController = [[TopContentViewController alloc] init];
    [topContentViewController initStoriesModel];
    
    topContentViewController.contentModel.storiesIDArray = [[NSMutableArray alloc] init];
    for (Top_Stories* ID in self.collectionModel.collectionSet) {
        [topContentViewController.contentModel.storiesIDArray addObject: ID];
    }
    topContentViewController.currentPage = index + 1;
    topContentViewController.topContentView = [[TopContentView alloc] initWithFrame: self.view.bounds];
    
    [self.navigationController pushViewController: topContentViewController animated: YES];
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
