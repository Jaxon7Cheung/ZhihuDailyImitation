//
//  ContentModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import <Foundation/Foundation.h>
#import "StoriesContentModel.h"
#import "FMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentModel : NSObject

@property (nonatomic, strong)NSMutableArray* storiesIDArray;

@property (nonatomic, strong)NSMutableSet* storiesLikeSet;
@property (nonatomic, strong)NSMutableSet* storiesCollectSet;
@property (nonatomic, strong)NSMutableDictionary* storiesExtraContentDictionary;

@property (nonatomic, strong)FMDatabase* likeDatabase;
@property (nonatomic, strong)FMDatabase* collectDatabase;

- (void)saveStoriesLikeSet;
- (void)deleteLikeSetWithID:(NSString*)ID;

- (void)saveStoriesCollectSet;
- (void)deleteCollectSetWithID:(NSString*)ID;

@end

NS_ASSUME_NONNULL_END
