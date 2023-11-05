//
//  StoriesCell.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoriesCell : UITableViewCell

@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* hintLabel;
@property (nonatomic, strong)UIImageView* imageMsg;

@end

NS_ASSUME_NONNULL_END
