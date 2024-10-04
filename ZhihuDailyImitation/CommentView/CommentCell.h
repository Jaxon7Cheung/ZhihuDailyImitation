//
//  CommentCell.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell

@property (nonatomic, strong)UIImageView* avatar;
@property (nonatomic, strong)UILabel* userName;
@property (nonatomic, strong)UILabel* commentContent;
@property (nonatomic, strong)UILabel* date;
@property (nonatomic, strong)UILabel* time;
@property (nonatomic, strong)UIButton* likesButton;
@property (nonatomic, strong)UILabel* numberOfLikes;
@property (nonatomic, strong)UIButton* commentButton;
@property (nonatomic, strong)UIButton* moreButton;


@end

NS_ASSUME_NONNULL_END
