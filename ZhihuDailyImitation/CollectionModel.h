//
//  CollectionModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionModel : NSObject

@property (nonatomic, strong)NSMutableSet* collectionSet;

@property (nonatomic, strong)NSMutableArray* titleArray;
@property (nonatomic, strong)NSMutableArray* imageMsgArray;

@property (nonatomic, strong)FMDatabase* collectDatabase;

- (void) reloadModel;

@end

NS_ASSUME_NONNULL_END
