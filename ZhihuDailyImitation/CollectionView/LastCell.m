//
//  LastCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "LastCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation LastCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.lastLabel = [[UILabel alloc] init];
        self.lastLabel.textColor = [UIColor grayColor];
        self.lastLabel.textAlignment = NSTextAlignmentCenter;
        self.lastLabel.font = [UIFont systemFontOfSize: 15];
        [self.contentView addSubview: self.lastLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [self.lastLabel makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.height.equalTo(15);
            make.width.equalTo(Screen_WIDTH);
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
