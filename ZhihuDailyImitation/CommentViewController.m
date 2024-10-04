//
//  CommentViewController.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/12.
//

#import "CommentViewController.h"
#import "Manager.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.commentDict = [[NSMutableDictionary alloc] init];
    self.commentView = [[CommentView alloc] initWithFrame: self.view.bounds];
    self.commentView.titleLabel.text = [NSString stringWithFormat: @"%ld条评论", self.comments];
    [self.view addSubview: self.commentView];
    [self setCommentsModel];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressBack) name: @"commentBack" object: nil];
}

- (void)setCommentsModel {
    dispatch_group_t group = dispatch_group_create();
    
    if (self.isLong) {
        dispatch_group_enter(group);
        [[Manager sharedManager] requestLongCommentsWithID: self.ID CommentsContentData:^(CommentModel * _Nonnull commentModel) {
                   NSDictionary* dict = [commentModel toDictionary];
                   [self.commentDict setObject: dict[@"comments"] forKey: @"long"];
                   self.isLong = YES;
                   dispatch_group_leave(group);
                } failure:^(NSError * _Nonnull error) {
                   if (error) NSLog(@"请求长评论失败");
                   dispatch_group_leave(group);
                }];
    }
    
    if (self.isShort) {
        dispatch_group_enter(group);
        [[Manager sharedManager] requestShortCommentsWithID: self.ID CommentsContentData:^(CommentModel * _Nonnull commentModel) {
                    NSDictionary* dict = [commentModel toDictionary];
                    [self.commentDict setObject: dict[@"comments"] forKey: @"short"];
                    self.isShort = YES;
                    dispatch_group_leave(group);
                } failure:^(NSError * _Nonnull error) {
                    if (error) NSLog(@"请求短评论失败");
                    dispatch_group_leave(group);
                }];
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.commentView.commentDict = self.commentDict;
            [self.commentView.tableView reloadData];
        });
    });
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pressBack {
    self.navigationController.toolbarHidden = NO;
    [self.navigationController popViewControllerAnimated: YES];
}

@end
