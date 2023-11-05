//
//  IndicatorCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import "IndicatorCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation IndicatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.indicator = [[UIActivityIndicatorView alloc] init];
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
        [self.contentView addSubview: self.indicator];
    }
    return self;
}

- (void)layoutSubviews {
    [self.indicator makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
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
