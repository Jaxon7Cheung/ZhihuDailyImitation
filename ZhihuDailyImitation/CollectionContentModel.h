//
//  CollectionContentModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionContentModel : JSONModel

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* image;

@end

NS_ASSUME_NONNULL_END
