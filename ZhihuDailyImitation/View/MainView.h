//
//  MainView.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UILabel* monthLabel;
@property (nonatomic, strong)UILabel* dayLabel;
@property (nonatomic, strong)UIView* grayRib;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIImageView* avatar;
@property (nonatomic, strong)UIView* navigationView;

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, assign)BOOL isLoading;

@property (nonatomic, strong)NSMutableArray* imageViewArray;
@property (nonatomic, strong)NSMutableArray* topTitleArray;
@property (nonatomic, strong)NSMutableArray* topUserNameArray;

@property (nonatomic, strong)NSMutableArray* storiesArray;
@property (nonatomic, strong)NSMutableArray* beforeDateArray;


- (void)setMainUI;
- (void)setNavigationView;
- (void)setTableView;

@end

NS_ASSUME_NONNULL_END
