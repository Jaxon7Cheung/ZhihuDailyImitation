//
//  StoriesCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/10/31.
//

#import "StoriesCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define MINIGAP [UIScreen mainScreen].bounds.size.width / 15

@implementation StoriesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
        self.titleLabel.numberOfLines = 2;
        
        self.hintLabel = [[UILabel alloc] init];
        self.hintLabel.font = [UIFont systemFontOfSize: 13];
        self.hintLabel.textColor = [UIColor lightGrayColor];
        
        self.imageMsg = [[UIImageView alloc] init];
        self.imageMsg.layer.cornerRadius = 3.5;
        self.imageMsg.layer.masksToBounds = YES;
    }
    
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.hintLabel];
    [self.contentView addSubview: self.imageMsg];
    
    
    return self;
}

- (void)layoutSubviews {
    
    [self.imageMsg makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.contentView.bounds.size.height / 7 * 5);
        make.right.equalTo(self.contentView.right).offset(-MINIGAP);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(MINIGAP);
        make.right.equalTo(self.imageMsg.left).offset(-MINIGAP);
        make.bottom.equalTo(self.contentView.centerY).offset(-3);
    }];
    
    [self.hintLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.left);
        make.right.equalTo(self.titleLabel.right);
        make.top.equalTo(self.contentView.centerY).offset(3);
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
