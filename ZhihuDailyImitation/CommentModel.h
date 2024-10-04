//
//  CommentModel.h
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/12.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Reply_To <NSObject>
@end

@protocol Comments <NSObject>
@end

@interface Reply_To : JSONModel

@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* author;

@end

@interface Comments : JSONModel

@property (nonatomic, copy)NSString* author;
@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* avatar;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* likes;
@property (nonatomic, strong)Reply_To* reply_to;

@end

@interface CommentModel : JSONModel

@property (nonatomic, copy)NSArray<Comments>* comments;

@end

NS_ASSUME_NONNULL_END
