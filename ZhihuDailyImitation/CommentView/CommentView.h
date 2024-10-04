//
//  CommentView.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView* navigationView;
@property (nonatomic, strong)UIButton* backButton;
@property (nonatomic, strong)UILabel* titleLabel;

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, copy)NSDictionary* commentDict;
@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, strong)NSMutableSet* unfoldSet;



@end

NS_ASSUME_NONNULL_END
