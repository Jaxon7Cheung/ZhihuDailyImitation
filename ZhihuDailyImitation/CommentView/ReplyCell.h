//
//  ReplyCell.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import "CommentCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReplyCell : CommentCell

//@property (nonatomic, strong)UILabel* mainContent;
@property (nonatomic, strong)UILabel* replyContent;
@property (nonatomic, strong)UIButton* unFoldButton;
@property (nonatomic, strong)UILabel* unFoldLabel;

@end

NS_ASSUME_NONNULL_END
