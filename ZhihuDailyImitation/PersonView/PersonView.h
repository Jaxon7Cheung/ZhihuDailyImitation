//
//  PersonView.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView* navigationView;
@property (nonatomic, strong)UIButton* backButton;

@property (nonatomic, strong)UITableView* tableView;

@end

NS_ASSUME_NONNULL_END
