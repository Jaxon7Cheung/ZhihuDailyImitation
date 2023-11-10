//
//  CollectionViewController.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import "CollectionView.h"
#import "CollectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController

@property (nonatomic, strong)CollectionView* collectionView;
@property (nonatomic, strong)CollectionModel* collectionModel;

@end

NS_ASSUME_NONNULL_END
