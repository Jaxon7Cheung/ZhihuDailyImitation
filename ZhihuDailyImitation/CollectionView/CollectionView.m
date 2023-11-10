//
//  CollectionView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "CollectionView.h"
#import "CollectionCell.h"
#import "LastCell.h"

#import "Manager.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define CellHeight [UIScreen mainScreen].bounds.size.height / 8.5
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 15

@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    self.navigationView = [[UIView alloc] init];
    self.navigationView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.navigationView];
    [self.navigationView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(Screen_WIDTH);
        make.height.equalTo(64);
        make.top.equalTo(self).offset(48);
    }];
    
    self.backButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.backButton setImage: [UIImage imageNamed: @"back.png"] forState: UIControlStateNormal];
    [self.backButton addTarget: self action: @selector(pressBack) forControlEvents: UIControlEventTouchUpInside];
    [self.navigationView addSubview: self.backButton];
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.navigationView);
            make.left.equalTo(self.backButton);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 19];
    self.titleLabel.text = @"收藏";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview: self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(255);
            make.height.equalTo(25);
            make.centerX.equalTo(self.navigationView);
            make.centerY.equalTo(self.navigationView);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview: self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationView.bottom);
            make.bottom.equalTo(self);
            make.width.equalTo(Screen_WIDTH);
    }];
    [self.tableView registerClass: [CollectionCell class] forCellReuseIdentifier: @"collectionCell"];
    [self.tableView registerClass: [LastCell class] forCellReuseIdentifier: @"lastCell"];
    
}

- (void)pressBack {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"pressBack-TWO" object: nil userInfo: nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%ld",[self.titleArray count]);
    return [self.titleArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != [self.titleArray count]) {
        CollectionCell* collectionCell = [self.tableView dequeueReusableCellWithIdentifier: @"collectionCell"];
        
        collectionCell.titleLabel.text = self.titleArray[indexPath.row];
        [Manager setImage: collectionCell.imageMsg WithString: self.imageMsgArray[indexPath.row]];
        
        return collectionCell;
    } else {
        LastCell* lastCell = [self.tableView dequeueReusableCellWithIdentifier: @"lastCell"];
        lastCell.lastLabel.text = @"没有更多内容";
        return lastCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"pressCollectionCell" object: nil userInfo: @{@"value" : [NSNumber numberWithInteger: index]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
