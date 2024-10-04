//
//  ReplyCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import "ReplyCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define TINYGAP [UIScreen mainScreen].bounds.size.width / 15

@implementation ReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
//        self.mainContent = [[UILabel alloc] init];
//        self.mainContent.font = [UIFont systemFontOfSize: 15];
//        self.mainContent.numberOfLines = 0;
//        [self.contentView addSubview: self.mainContent];
        
        self.replyContent = [[UILabel alloc] init];
        self.replyContent.font = [UIFont systemFontOfSize: 13];
        self.replyContent.textColor = [UIColor colorWithRed: 137.0 / 255 green: 137.0 / 255 blue: 137.0 / 255 alpha: 1.0];
        self.replyContent.numberOfLines = 2;
        [self.contentView addSubview: self.replyContent];
        
        self.unFoldButton = [UIButton buttonWithType: UIButtonTypeSystem];
        self.unFoldButton.tintColor = [UIColor grayColor];
        [self.contentView addSubview: self.unFoldButton];
        self.unFoldLabel = [[UILabel alloc] init];
        self.unFoldLabel.font = [UIFont systemFontOfSize: 13];
        self.unFoldLabel.textColor = [UIColor colorWithRed: 175.0 / 255 green: 175.0 / 255 blue: 175.0 / 255 alpha: 1.0];
        self.unFoldLabel.text = @" · 展开全文";
        [self.contentView addSubview: self.unFoldLabel];
        
        [self.commentContent makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(48);
            make.left.equalTo(self.avatar.right).offset(10);
            make.right.equalTo(self.contentView.right).offset(-20);
            make.height.lessThanOrEqualTo(Screen_HEIGHT);
        }];
        
        [self.replyContent makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.commentContent.bottom).offset(10);
    //                make.top.equalTo(self.contentView.top).offset(50);


                    make.left.equalTo(self.commentContent.left);
                    make.right.equalTo(self.contentView).offset(-37);
                    make.bottom.equalTo(self.contentView.bottom).offset(-60);
        }];
        
        [self.unFoldLabel makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.contentView).offset(-10);
                    make.left.equalTo(self.time.right).offset(10);
                    make.height.equalTo(15);
                    make.width.equalTo(77);
        }];
        
        [self.unFoldButton makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.contentView).offset(-10);
                    make.left.equalTo(self.time.right).offset(10);
                    make.height.equalTo(15);
                    make.width.equalTo(77);
        }];
    }
    

    
    return self;
}

- (void)layoutSubviews {
    
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
