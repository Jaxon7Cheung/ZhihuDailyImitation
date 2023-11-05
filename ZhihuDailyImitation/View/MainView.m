//
//  MainView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/30.
//

#import "Manager.h"
#import "DateModel.h"

#import "MainView.h"
#import "TopStoriesCell.h"
#import "StoriesCell.h"
#import "IndicatorCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CellHeight [UIScreen mainScreen].bounds.size.height / 8.5
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 15

@implementation MainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setMainUI {
    self.backgroundColor = [UIColor whiteColor];
    [self setNavigationView];
    [self setTableView];
    
}

#pragma mark NavigationView
- (void)setNavigationView {
    self.navigationView = [[UIView alloc] init];
    [self addSubview: self.navigationView];
    [self.navigationView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(Screen_WIDTH);
        make.height.equalTo(64);
        
        //状态栏单例对象
//        make.top.equalTo([UIApplication sharedApplication]);
        make.top.equalTo(self).offset(48);

    }];
    
    self.monthLabel = [[UILabel alloc] init];
    self.monthLabel.font = [UIFont systemFontOfSize: 12];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview: self.monthLabel];
    [self.monthLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(Screen_WIDTH / 6);
        make.height.equalTo(16);
        make.bottom.equalTo(self.navigationView).offset(-10);
    }];
    
    self.dayLabel = [[UILabel alloc] init];
    self.dayLabel.font = [UIFont boldSystemFontOfSize: 25];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview: self.dayLabel];
    [self.dayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(Screen_WIDTH / 6);
        make.height.equalTo(32);
        make.top.equalTo(self.navigationView).offset(6);
    }];
    
    self.grayRib = [[UIView alloc] init];
    self.grayRib.backgroundColor = [UIColor lightGrayColor];
    [self.navigationView addSubview: self.grayRib];
    [self.grayRib makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(1);
        make.height.equalTo(40);
        make.centerY.equalTo(self.navigationView);
        make.left.equalTo(self.navigationView).offset(Screen_WIDTH / 6);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 30];
    [self.navigationView addSubview: self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(150);
            make.height.equalTo(40);
            make.centerY.equalTo(self.navigationView);
            make.left.equalTo(self.navigationView).offset(Screen_WIDTH / 6 + 18);
    }];
    
    self.avatar = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"灰太狼.png"]];
    self.avatar.layer.cornerRadius = 24;
    self.avatar.clipsToBounds = YES;
    self.avatar.userInteractionEnabled = YES;
    [self.navigationView addSubview: self.avatar];
    [self.avatar makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(48);
        make.centerY.equalTo(self.navigationView);
        make.right.equalTo(-10);
    }];
}

#pragma mark TableView

- (void)setTableView {
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //分区之间有间隔，区头有留白
        self.tableView.sectionHeaderTopPadding = 0;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.bounces = NO;
        
        [self.tableView registerClass: [TopStoriesCell class] forCellReuseIdentifier: @"topStories"];
        [self.tableView registerClass: [StoriesCell class] forCellReuseIdentifier: @"stories"];
        [self.tableView registerClass: [IndicatorCell class] forCellReuseIdentifier: @"indicator"];
        [self addSubview: self.tableView];
        [self.tableView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationView.bottom);
            make.width.equalTo(Screen_WIDTH);
            make.bottom.equalTo(self.bottom);
        }];
    }
    
    self.isLoading = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.storiesArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    } else if (section == self.storiesArray.count) {
        return [self.storiesArray[section - 1] count] + 1;
    } else {
        return [self.storiesArray[section - 1] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        TopStoriesCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"topStories"];
        
        cell.titleArray = self.topTitleArray;
        cell.userNameArray = self.topUserNameArray;
        cell.imageViewArray = self.imageViewArray;
        return cell;
    } else if (indexPath.section == self.storiesArray.count && indexPath.row == [self.storiesArray[indexPath.section - 1] count]) {
        IndicatorCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"indicator"];
        
        if (self.isLoading) {
            [cell.indicator startAnimating];
        } else {
            [cell.indicator stopAnimating];
        }
        
        return cell;
    } else {
        StoriesCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"stories"];
        
        cell.titleLabel.text = self.storiesArray[indexPath.section - 1][indexPath.row][@"title"];
        cell.hintLabel.text = self.storiesArray[indexPath.section - 1][indexPath.row][@"hint"];
        [Manager setImage: cell.imageMsg WithString: self.storiesArray[indexPath.section - 1][indexPath.row][@"images"][0]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section && !indexPath.row) {
        return CellHeight * 3.5;
    } else if (indexPath.section == self.storiesArray.count && indexPath.row == [self.storiesArray[indexPath.section - 1] count]) {
        return CellHeight * 2 / 3;
    } else {
        return CellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 1) {
        return CellHeight / 3;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 1) {
        UIView* view = [[UIView alloc] init];
        
        UILabel* dateLabel = [[UILabel alloc] init];
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont boldSystemFontOfSize: 15];
        dateLabel.text = [DateModel getDateWithTimeString: self.beforeDateArray[section - 1]];
        [view addSubview: dateLabel];
        
        UIView* grayView = [[UIView alloc] init];
        grayView.backgroundColor = [UIColor colorWithRed: 231.0 / 255 green: 231.0 / 255 blue: 231.0 / 255 alpha: 1];
        [view addSubview: grayView];
        
        [dateLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.left).offset(MINIGAP);
            make.centerY.equalTo(view.centerY);
        }];
        
        [grayView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(1);
            make.left.equalTo(dateLabel.right).offset(MINIGAP);
            make.right.equalTo(view.right);
            make.centerY.equalTo(view.centerY);
        }];
        
        return view;
    } else {
        return nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.isLoading) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat Y = scrollView.contentSize.height - scrollView.bounds.size.height;
        
        if  (offsetY >= Y) {
            self.isLoading = YES;
            [self.tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"loadBeforeStories" object: nil];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == self.storiesArray.count && indexPath.row == [self.storiesArray[indexPath.section - 1] count]) {
        return;
    }
    
    if (indexPath.section != 0) {
        NSInteger index = 0;
        for (NSInteger i = 0; i < indexPath.section - 1; i++) {
            index += [self.storiesArray[i] count];
        }
        index += indexPath.row;
        
        [[NSNotificationCenter defaultCenter] postNotificationName: @"pressStoriesCell" object: nil userInfo: @{@"value" : [NSNumber numberWithInteger : index]}];
    }
    
}


@end
