//
//  MainViewController.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

#import "MainView.h"
#import "LatestStoriesModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

@property (nonatomic, strong)Manager* manager;

@property (nonatomic, strong)MainView* mainView;

@property (nonatomic, strong)LatestStoriesModel* latestStoriesModel;

@property (nonatomic, strong)NSMutableArray* imageViewArray;
@property (nonatomic, strong)NSMutableArray* topTitleArray;
@property (nonatomic, strong)NSMutableArray* topUserNameArray;

@property (nonatomic, strong)NSMutableArray* beforeStoriesModelArray;



@end

NS_ASSUME_NONNULL_END
