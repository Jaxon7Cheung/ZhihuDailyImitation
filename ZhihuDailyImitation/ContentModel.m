//
//  ContentModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/1.
//

#import "ContentModel.h"

@implementation ContentModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storiesIDArray = [[NSMutableArray alloc] init];
        self.storiesExtraContentDictionary = [[NSMutableDictionary alloc] init];
        
        self.storiesLikeSet = [[NSMutableSet alloc] init];
        self.storiesCollectSet = [[NSMutableSet alloc] init];
        
        [self createStoriesLikeSet];
        [self createStoriesCollectSet];
    }
    
    return self;
}

#pragma mark 点赞操作
- (void)createStoriesLikeSet {
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* fileName = [doc stringByAppendingPathComponent: @"likeDatabase.sqlite"];
    NSLog(@"%@", fileName);
    self.likeDatabase = [FMDatabase databaseWithPath: fileName];
    
    if ([self.likeDatabase open]) {
        BOOL result = [self.likeDatabase executeUpdate: @"CREATE TABLE IF NOT EXISTS likeDatabase (idLabel text NOT NULL)"];
        if (result) {
            FMResultSet* resultSet = [self.likeDatabase executeQuery: @"SELECT * FROM likeDatabase"];
            while([resultSet next]) {
                [self.storiesLikeSet addObject: [resultSet stringForColumn: @"idLabel"]];
            }
            NSLog(@"create table succeed");
        } else {
            NSLog(@"fail to open database");
        }
        [self.likeDatabase close];
    }
}

- (void)saveStoriesLikeSet {
    if ([self.likeDatabase open]) {
        for (NSString* ID in self.storiesLikeSet) {
            FMResultSet* resultSet = [self.likeDatabase executeQuery: @"SELECT * FROM likeDatabase WHERE idLabel = ?", ID];
            if (![resultSet next]) {
                BOOL result = [self.likeDatabase executeUpdate: @"INSERT INTO likeDatabase (idLabel) VALUES (?)", ID];
                if (result) {
                    NSLog(@"insert table succeed");
                } else {
                    NSLog(@"insert table error");
                }
            }
        }
        [self.likeDatabase close];
    }
}

- (void)deleteLikeSetWithID:(NSString*)ID {
    if ([self.likeDatabase open]) {
        BOOL result = [self.likeDatabase executeUpdate: @"delete from likeDatabase WHERE idLabel = ?", ID];
        if (result) {
            NSLog(@"delete table succeed");
        } else {
            NSLog(@"delete table error");
        }
        [self.likeDatabase close];
    }
}

#pragma mark 收藏操作
- (void)createStoriesCollectSet {
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filename = [doc stringByAppendingPathComponent: @"collectDatabase.sqlite"];
    
    self.collectDatabase = [FMDatabase databaseWithPath: filename];
    
    if ([self.collectDatabase open]) {
        BOOL result = [self.collectDatabase executeUpdate: @"CREATE TABLE IF NOT EXISTS collectDatabase (idLabel text NOT NULL)"];
        
        if (result) {
            FMResultSet* resultSet = [self.collectDatabase executeQuery: @"SELECT * FROM collectDatabase"];
            while ([resultSet next]) {
                [self.storiesCollectSet addObject: [resultSet stringForColumn: @"idLabel"]];
            }
            NSLog(@"create table succeed");
        } else {
            NSLog(@"create table error");
        }
        [self.collectDatabase close];
    }
}

- (void)saveStoriesCollectSet {
    if ([self.collectDatabase open]) {
        for (NSString* ID in self.storiesCollectSet) {
            FMResultSet* resultSet = [self.collectDatabase executeQuery: @"SELECT * FROM collectDatabase WHERE idLabel = ?", ID];
            if (![resultSet next]) {
                BOOL result = [self.collectDatabase executeUpdate: @"INSERT INTO collectDatabase (idLabel) VALUES (?)", ID];
                if (result) {
                    NSLog(@"insert table succeed");
                } else {
                    NSLog(@"insert table error");
                }
            }
        }
        [self.collectDatabase close];
    }
}

- (void)deleteCollectSetWithID:(NSString*)ID {
    if ([self.collectDatabase open]) {
        BOOL result = [self.collectDatabase executeUpdate: @"delete from collectDatabase WHERE idLabel = ?", ID];
        if (result) {
            NSLog(@"delete succeed");
        } else {
            NSLog(@"delete error");
        }
    }
}



@end
