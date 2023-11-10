//
//  CollectionModel.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "CollectionModel.h"

@implementation CollectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.collectionSet = [[NSMutableSet alloc] init];
        self.titleArray = [[NSMutableArray alloc] init];
        self.imageMsgArray = [[NSMutableArray alloc] init];
        
        [self createCollectData];
    }
    
    return self;
}

- (void)createCollectData {
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filename = [doc stringByAppendingPathComponent: @"collectDatabase.sqlite"];
    //NSLog(@"%@", filename);
    
    self.collectDatabase = [FMDatabase databaseWithPath:filename];
    
    if ([self.collectDatabase open]) {
        BOOL result = [self.collectDatabase executeUpdate: @"CREATE TABLE IF NOT EXISTS collectDatabae (idLabel text NOT NULL)"];
        if (result) {
            FMResultSet* resultSet = [self.collectDatabase executeQuery: @"SELECT * FROM collectDatabase"];
            while ([resultSet next]) {
                [self.collectionSet addObject: [resultSet objectForColumn: @"idLabel"]];
            }
            NSLog(@"create table succeed");
        } else {
            NSLog(@"create table error");
        }
    }
}

- (void)reloadModel {
    self.collectionSet = [[NSMutableSet alloc] init];
    self.titleArray = [[NSMutableArray alloc] init];
    self.imageMsgArray = [[NSMutableArray alloc] init];
    
    [self createCollectData];
}

@end
