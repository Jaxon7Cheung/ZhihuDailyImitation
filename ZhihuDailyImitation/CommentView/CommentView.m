//
//  CommentView.m
//  ZhihuDailyImitation
//
//  Created by 张旭洋 on 2023/11/11.
//

#import "CommentView.h"
#import "CommentCell.h"
#import "ReplyCell.h"

#import "Manager.h"
#import "DateModel.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define AVATAR_SIZE [UIScreen mainScreen].bounds.size.width / 12


@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    self.unfoldSet = [[NSMutableSet alloc] init];
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
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 19];
//    self.titleLabel.text = @"%@条评论";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview: self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(255);
            make.height.equalTo(25);
            make.centerX.equalTo(self.navigationView);
            make.centerY.equalTo(self.navigationView);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self addSubview: self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(Screen_WIDTH);
            make.top.equalTo(self.navigationView.bottom);
            make.bottom.equalTo(self);
    }];
    [self.tableView registerClass: [CommentCell class] forCellReuseIdentifier: @"commentCell"];
    [self.tableView registerClass: [ReplyCell class] forCellReuseIdentifier: @"replyCell"];
    
}

- (void)pressBack {
    [[NSNotificationCenter defaultCenter] postNotificationName: @"commentBack" object: nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.commentDict count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section && self.commentDict[@"long"]) {
        return [self.commentDict[@"long"] count];
    } else {
        return [self.commentDict[@"short"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section && self.commentDict[@"long"]) {
        if (!self.commentDict[@"long"][indexPath.row][@"reply_to"]) {
            CommentCell* commentCell = [self.tableView dequeueReusableCellWithIdentifier: @"commentCell"];
            
            [Manager setImage: commentCell.avatar WithString: self.commentDict[@"long"][indexPath.row][@"avatar"]];
            commentCell.userName.text = self.commentDict[@"long"][indexPath.row][@"author"];
            commentCell.commentContent.text = self.commentDict[@"long"][indexPath.row][@"content"];
            commentCell.date.text = [DateModel getCommentDateWithTimeString: self.commentDict[@"long"][indexPath.row][@"time"]];
            commentCell.time.text = [DateModel getCommentTimeWithTimeString: self.commentDict[@"long"][indexPath.row][@"time"]];
            if ([self.commentDict[@"long"][indexPath.row][@"likes"] isEqualToString: @"0"]) {
                commentCell.numberOfLikes.text = @"";
            } else {
                commentCell.numberOfLikes.text = self.commentDict[@"long"][indexPath.row][@"likes"];
            }
            
            return commentCell;
            
        } else {
            ReplyCell* replyCell = [self.tableView dequeueReusableCellWithIdentifier: @"replyCell"];
            
            [Manager setImage: replyCell.avatar WithString: self.commentDict[@"long"][indexPath.row][@"avatar"]];
            replyCell.userName.text = self.commentDict[@"long"][indexPath.row][@"author"];
            replyCell.commentContent.text = self.commentDict[@"long"][indexPath.row][@"content"];
            replyCell.date.text = [DateModel getCommentDateWithTimeString: self.commentDict[@"long"][indexPath.row][@"time"]];
            replyCell.time.text = [DateModel getCommentTimeWithTimeString: self.commentDict[@"long"][indexPath.row][@"time"]];
            if ([self.commentDict[@"long"][indexPath.row][@"likes"] isEqualToString: @"0"]) {
                replyCell.numberOfLikes.text = @"";
            } else {
                replyCell.numberOfLikes.text = self.commentDict[@"long"][indexPath.row][@"likes"];
            }
            
            NSDictionary* replyDict = self.commentDict[@"long"][indexPath.row][@"reply_to"];
            NSString* replyString = [NSString stringWithFormat: @"//%@：%@", replyDict[@"author"], replyDict[@"content"]];
            replyCell.replyContent.text = replyString;
            
            
            replyCell.unFoldButton.tag = (indexPath.section + 1) * 11111 + (indexPath.row + 1) * 11;
            if ([self labelNeedLinesWithString: replyString] > 2) {
                if ([self.unfoldSet containsObject: [NSString stringWithFormat: @"%ld", replyCell.unFoldButton.tag]]) {
                    replyCell.unFoldLabel.text = @" · 收起";
                    replyCell.replyContent.numberOfLines = 0;
                } else {
                    replyCell.unFoldLabel.text = @" · 展开全文";
                    replyCell.replyContent.numberOfLines = 2;

                }
            } else {
                replyCell.unFoldLabel.text = @"";
                replyCell.replyContent.numberOfLines = 2;
                replyCell.unFoldButton.tag = 0;
            }
            
            [replyCell.unFoldButton addTarget: self action: @selector(pressUnfold:) forControlEvents: UIControlEventTouchUpInside];
            
            return replyCell;
        }
    } else {
        if (!self.commentDict[@"short"][indexPath.row][@"reply_to"]) {
            CommentCell* commentCell = [self.tableView dequeueReusableCellWithIdentifier: @"commentCell"];
            
            [Manager setImage: commentCell.avatar WithString: self.commentDict[@"short"][indexPath.row][@"avatar"]];
            commentCell.userName.text = self.commentDict[@"short"][indexPath.row][@"author"];
            commentCell.commentContent.text = self.commentDict[@"short"][indexPath.row][@"content"];
            commentCell.date.text = [DateModel getCommentDateWithTimeString: self.commentDict[@"short"][indexPath.row][@"time"]];
            commentCell.time.text = [DateModel getCommentTimeWithTimeString: self.commentDict[@"short"][indexPath.row][@"time"]];
            if ([self.commentDict[@"short"][indexPath.row][@"likes"] isEqualToString: @"0"]) {
                commentCell.numberOfLikes.text = @"";
            } else {
                commentCell.numberOfLikes.text = self.commentDict[@"short"][indexPath.row][@"likes"];
            }
            
            return commentCell;
            
        } else {
            ReplyCell* replyCell = [self.tableView dequeueReusableCellWithIdentifier: @"replyCell"];
            
            [Manager setImage: replyCell.avatar WithString: self.commentDict[@"short"][indexPath.row][@"avatar"]];
            replyCell.userName.text = self.commentDict[@"short"][indexPath.row][@"author"];
            replyCell.commentContent.text = self.commentDict[@"short"][indexPath.row][@"content"];
            replyCell.date.text = [DateModel getCommentDateWithTimeString: self.commentDict[@"short"][indexPath.row][@"time"]];
            replyCell.time.text = [DateModel getCommentTimeWithTimeString: self.commentDict[@"short"][indexPath.row][@"time"]];
            if ([self.commentDict[@"short"][indexPath.row][@"likes"] isEqualToString: @"0"]) {
                replyCell.numberOfLikes.text = @"";
            } else {
                replyCell.numberOfLikes.text = self.commentDict[@"short"][indexPath.row][@"likes"];
            }
            
            NSDictionary* replyDict = self.commentDict[@"short"][indexPath.row][@"reply_to"];
            NSString* replyString = [NSString stringWithFormat: @"//%@：%@", replyDict[@"author"], replyDict[@"content"]];
            replyCell.replyContent.text = replyString;
            
            
            replyCell.unFoldButton.tag = (indexPath.section + 1) * 11111 + (indexPath.row + 1) * 11;
            if ([self labelNeedLinesWithString: replyString] > 2) {
                if ([self.unfoldSet containsObject: [NSString stringWithFormat: @"%ld", replyCell.unFoldButton.tag]]) {
                    replyCell.unFoldLabel.text = @" · 收起";
                    replyCell.replyContent.numberOfLines = 0;
//                    NSLog(@"1234");
                } else {
                    replyCell.unFoldLabel.text = @" · 展开全文";
                    replyCell.replyContent.numberOfLines = 2;
//                    NSLog(@"12345");
                }
            } else {
                replyCell.unFoldLabel.text = @"";
                replyCell.replyContent.numberOfLines = 2;
                replyCell.unFoldButton.tag = 0;
            }
            
            [replyCell.unFoldButton addTarget: self action: @selector(pressUnfold:) forControlEvents: UIControlEventTouchUpInside];
            
            return replyCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.width)];
    label.font = [UIFont boldSystemFontOfSize: 15];
    
    
    if (!section && self.commentDict[@"long"]) {
        label.text = [NSString stringWithFormat: @"%ld条长评", [self.commentDict[@"long"] count]];
    } else {
        label.text = [NSString stringWithFormat: @"%ld条短评", [self.commentDict[@"short"] count]];
    }
    return view;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSInteger)labelNeedLinesWithString: (NSString*)string {
    CGFloat width = Screen_WIDTH - (AVATAR_SIZE + 50);

    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize: 16];
    
    NSInteger sum = 0;
    
    NSArray* splitText = [string componentsSeparatedByString: @"\n"];
    for (NSString* sText in splitText) {
        label.text = sText;
        
        CGSize textSize = [label systemLayoutSizeFittingSize: CGSizeZero];
        NSInteger lines = ceilf(textSize.width / width);
        
        lines = lines == 0 ? 1 : lines;
        sum += lines;
    }
    
    return sum;
}

- (void)pressUnfold: (UIButton *)button {
    if (!button.tag) {
        return;
    }
    
    NSString* buttonTagString = [NSString stringWithFormat: @"%ld", button.tag];
    if ([self.unfoldSet containsObject: buttonTagString]) {
        [self.unfoldSet removeObject: buttonTagString];
        
        [self.tableView reloadData];
//        NSLog(@"aaa");
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
    } else {
        [self.unfoldSet addObject: buttonTagString];
        
        [self.tableView reloadData];
//        [self.tableView beginUpdates];
//        [self.tableView endUpdates];
    }
}

@end
