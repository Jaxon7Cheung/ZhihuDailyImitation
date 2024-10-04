//
//  CommentViewController.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/12.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController

@property (nonatomic, strong)CommentView* commentView;
@property (nonatomic, strong)NSMutableDictionary* commentDict;

@property (nonatomic, assign)NSInteger comments;
@property (nonatomic, assign)BOOL isLong;
@property (nonatomic, assign)BOOL isShort;

@property (nonatomic, copy)NSString* ID;

@end

NS_ASSUME_NONNULL_END
