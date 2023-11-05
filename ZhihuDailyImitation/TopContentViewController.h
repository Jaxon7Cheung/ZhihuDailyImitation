//
//  TopContentViewController.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import <UIKit/UIKit.h>
#import "ContentModel.h"
#import "TopContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopContentViewController : UIViewController

@property (nonatomic, strong)ContentModel* contentModel;
@property (nonatomic, strong)TopContentView* topContentView;

@property (nonatomic, assign)NSInteger currentPage;

@property (nonatomic, strong)UIBarButtonItem* backItem;
@property (nonatomic, strong)UIBarButtonItem* grayItem;

@property (nonatomic, strong)UILabel* commentLabel;
@property (nonatomic, strong)UIBarButtonItem* commentItem;

@property (nonatomic, strong)UILabel* likeLabel;
@property (nonatomic, strong)UIButton* likeButton;
@property (nonatomic, strong)UIBarButtonItem* likeItem;

@property (nonatomic, strong)UIButton* collectButton;
@property (nonatomic, strong)UIBarButtonItem* collectItem;

@property (nonatomic, strong)UIBarButtonItem* shareItem;


- (void) initStoriesModel;

@end

NS_ASSUME_NONNULL_END
