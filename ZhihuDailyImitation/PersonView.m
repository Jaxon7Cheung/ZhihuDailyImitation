//
//  PersonView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/6.
//

#import "PersonView.h"

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
//    self.backButton = [UIButton systemButtonWithImage: [UIImage imageNamed: @"back.png"] target: self action: @selector(pressBack)];
    [self.navigationView addSubview: self.backButton];
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backButton);
            make.left.equalTo(self.backButton);
    }];

    self.avatar = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"avatar.png"]];
    self.avatar.layer.cornerRadius = 64;
    self.avatar.clipsToBounds = YES;
    //self.avatar.userInteractionEnabled = YES;
    [self.navigationView addSubview: self.avatar];
    [self.avatar makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.equalTo(128);
            make.top.equalTo(self.navigationView).offset(-55);
    }];
}

- (void)pressBack {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"backNotification" object: nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
