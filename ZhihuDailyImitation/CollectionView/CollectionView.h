//
//  CollectionView.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView* navigationView;
@property (nonatomic, strong)UIButton* backButton;
@property (nonatomic, strong)UILabel* titleLabel;

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)NSMutableArray* titleArray;
@property (nonatomic, strong)NSMutableArray* imageMsgArray;

@end

NS_ASSUME_NONNULL_END
