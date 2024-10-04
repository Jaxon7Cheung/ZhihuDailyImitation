//
//  CommentCell.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import "CommentCell.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define AVATAR_SIZE [UIScreen mainScreen].bounds.size.width / 12
#define TINYGAP [UIScreen mainScreen].bounds.size.width / 20

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.avatar = [[UIImageView alloc] init];
        self.avatar.layer.cornerRadius = AVATAR_SIZE / 2;
        self.avatar.clipsToBounds = YES;
        
        self.userName = [[UILabel alloc] init];
        self.userName.font = [UIFont boldSystemFontOfSize: 15];
        
#pragma mark HEIGHT
        //reply 137 137 137.0 / 255
        self./*self.self.*/commentContent = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
        self.commentContent.font = [UIFont systemFontOfSize: 15];
        self.commentContent.numberOfLines = 0;
        
        self.date = [[UILabel alloc] init];
        self.date.font = [UIFont systemFontOfSize: 13];
        self.date.textColor = [UIColor colorWithRed: 175.0 / 255 green: 175.0 / 255 blue: 175.0 / 255 alpha: 1.0];
        
        self.time = [[UILabel alloc] init];
        self.time.font = [UIFont systemFontOfSize: 13];
        self.time.textColor = [UIColor colorWithRed: 175.0 / 255 green: 175.0 / 255 blue: 175.0 / 255 alpha: 1.0];
        
        [self.contentView addSubview: self.avatar];
        [self.contentView addSubview: self.userName];
        [self.contentView addSubview: self.commentContent];
        [self.contentView addSubview: self.date];
        [self.contentView addSubview: self.time];
        
        [self.avatar makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView.left).offset(20);
                    make.top.equalTo(self.contentView.top).offset(20);
                    make.size.equalTo(AVATAR_SIZE);
        }];
        
        [self.userName makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.avatar.right).offset(10);
                    make.top.equalTo(self.contentView.top).offset(20);
                    make.width.offset(Screen_WIDTH);
        }];
        
        [self.commentContent makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView).offset(48);
                    make.left.equalTo(self.avatar.right).offset(10);
                    make.right.offset(-20);
                    make.height.lessThanOrEqualTo(Screen_HEIGHT);
                    make.bottom.equalTo(self.contentView).offset(-60);
        }];
        
        [self.date makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.avatar.right).offset(10);
                    make.bottom.equalTo(self.contentView).offset(-20);
        }];
        
        [self.time makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.contentView).offset(-20);
                    make.left.equalTo(self.avatar.right).offset(10);
        }];
        
//        self.commentButton = [UIButton buttonWithType: UIButtonTypeCustom];
//        [self.commentButton setImage: [UIImage imageNamed: @"reply.png"] forState: UIControlStateNormal];
//        [self.contentView addSubview: self.commentButton];
//        [self.commentButton makeConstraints:^(MASConstraintMaker *make) {
//                    make.bottom.equalTo(self.contentView).offset(20);
//                    make.right.equalTo(self.contentView).offset(40);
//                    make.size.equalTo(20);
//        }];
//
//        self.likesButton = [UIButton buttonWithType: UIButtonTypeCustom];
//        [self.likesButton setImage: [UIImage imageNamed: @"like.png"] forState: UIControlStateNormal];
//        [self.contentView addSubview: self.likesButton];
//        [self.likesButton makeConstraints:^(MASConstraintMaker *make) {
//                    make.bottom.equalTo(self.contentView).offset(20);
//                    make.right.equalTo(self.commentButton.right).offset(40);
//                    make.size.equalTo(20);
//        }];
//
//        self.numberOfLikes = [[UILabel alloc] init];
//        self.numberOfLikes.font = [UIFont systemFontOfSize: 10];
//        self.numberOfLikes.textColor = [UIColor colorWithRed: 137.0 / 255 green: 137.0 / 255 blue:137.0 / 255 alpha: 1.0];
//        [self.contentView addSubview: self.numberOfLikes];
//        [self.numberOfLikes makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(self.likesButton).offset(40);
//                    make.bottom.equalTo(self.contentView).offset(20);
//                    make.size.equalTo(20);
//        }];
//
//        self.moreButton = [UIButton buttonWithType: UIButtonTypeCustom];
//        [self.moreButton setImage: [UIImage imageNamed: @"more.png"] forState: UIControlStateNormal];
//        [self.contentView addSubview: self.moreButton];
//        [self.moreButton makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(self.commentButton.right);
//                    make.centerY.equalTo(self.userName);
//                    make.size.equalTo(20);
//        }];
    }
    
    return self;
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
