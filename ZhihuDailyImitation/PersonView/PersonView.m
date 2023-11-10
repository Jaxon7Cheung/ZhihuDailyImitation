//
//  PersonView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/6.
//

#import "PersonView.h"
#import "PersonCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation PersonView

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
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    [self addSubview: self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(Screen_WIDTH);
            make.top.equalTo(self.navigationView.bottom);
            make.bottom.equalTo(self);
    }];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"normalCell"];
    [self.tableView registerClass: [PersonCell class] forCellReuseIdentifier: @"personCell"];
}

- (void)pressBack {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"backNotification" object: nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: @"normalCell"];
    PersonCell* personCell = [self.tableView dequeueReusableCellWithIdentifier: @"personCell"];
    
    
    if (!indexPath.row) {
        personCell.nameLabel.text = @"槲寄生";
        personCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return personCell;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 1) {
            cell.textLabel.text = @"我的收藏";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"消息中心";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        return 256;
    } else {
        return 67;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"didselectCollection" object: nil userInfo: nil];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
