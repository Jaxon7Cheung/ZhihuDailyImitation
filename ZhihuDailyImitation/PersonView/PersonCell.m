//
//  PersonCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "PersonCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation PersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.avatar = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"灰太狼.png"]];
        self.avatar.layer.cornerRadius = 64;
        self.avatar.clipsToBounds = YES;
        [self.contentView addSubview: self.avatar];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont boldSystemFontOfSize: 25];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview: self.nameLabel];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.avatar makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.equalTo(128);
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).dividedBy(1.5);
    }];
    
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(255);
            make.height.equalTo(25);
            make.centerX.equalTo(self.avatar);
            make.top.equalTo(self.avatar.bottom).offset(25);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
