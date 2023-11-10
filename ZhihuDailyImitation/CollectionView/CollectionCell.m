//
//  CollectionCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/10.
//

#import "CollectionCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 15

@implementation CollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont boldSystemFontOfSize: 16];
        self.titleLabel.numberOfLines = 2;
        
        self.imageMsg = [[UIImageView alloc] init];
        self.imageMsg.layer.cornerRadius = 3.5;
        self.imageMsg.layer.masksToBounds = YES;
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self.contentView addSubview: self.titleLabel];
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
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(MINIGAP);
            make.right.equalTo(self.imageMsg.left).offset(-MINIGAP);
            make.height.equalTo(self.imageMsg.height);
    }];
//    self.titleLabel.frame = CGRectMake(10, 10, 100, 20);
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
