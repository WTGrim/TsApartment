//
//  CircumDetailCommentCell.m
//  TsApartment
//
//  Created by 董文涛 on 2018/6/7.
//  Copyright © 2018年 PmMaster. All rights reserved.
//

#import "CircumDetailCommentCell.h"
#import "PhotoGroupView.h"
#import <Masonry.h>

#define ICON_W 60
@interface CircumDetailCommentCell()

@property(nonatomic, strong)UIImageView *headerImageView;
@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *gradeTitle;
@property(nonatomic, strong)UIView *starBgView;
@property(nonatomic, strong)UILabel *commentDetailLabel;
@property(nonatomic, strong)PhotoGroupView *photoView;
@property(nonatomic, strong)UIView *line;

@property(nonatomic, strong)NSArray *photoArray;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, assign)CGFloat cellHeight;

@end

@implementation CircumDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setCellWithDict:(NSDictionary *)dict indexPath:(NSIndexPath *)indexPath cellHeight:(void (^)(CGFloat))cellHeight{
    _indexPath = indexPath;

    //设置图片及高度回调
    NSArray *photoUrlArray = @[];
    CGFloat textH = [self getTextHeight:_commentDetailLabel.text];
    WEAKSELF;
    _photoView.photoGroupHeightBlock = ^(CGFloat height) {
        if (cellHeight) {
            cellHeight(height + textH + 100);
        }
    };
    
    _photoView.imageUrlArray = photoUrlArray;
}

- (void)setupUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _headerImageView = [UIImageView new];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_headerImageView];
    
    _userNameLabel = [UILabel new];
    [self.contentView addSubview:_userNameLabel];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = ThemeColor_BlackText;
    
    _timeLabel = [UILabel new];
    [self.contentView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor darkGrayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    
    _gradeTitle = [UILabel new];
    [self.contentView addSubview:_gradeTitle];
    _gradeTitle.font = [UIFont systemFontOfSize:12];
    _gradeTitle.textColor = ThemeColor_BlackText;
    
    _starBgView = [UIView new];
    [self.contentView addSubview:_starBgView];
    
    _commentDetailLabel = [UILabel new];
    [self.contentView addSubview:_commentDetailLabel];
    _commentDetailLabel.textColor = [UIColor blackColor];
    _commentDetailLabel.font = [UIFont systemFontOfSize:12];
    _commentDetailLabel.numberOfLines = 0;
    
    _photoView = [PhotoGroupView new];
    [self.contentView addSubview:_photoView];
    
    _line = [UIView new];
    _line.backgroundColor = ThemeColor_line;
    [self.contentView addSubview:_line];
    
    [self setConstraints];
}


- (void)setConstraints{
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(20);
        make.width.height.equalTo(@(ICON_W));
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(15);
        make.top.equalTo(self.headerImageView);
        make.right.equalTo(self.timeLabel.mas_right).offset(-15);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.userNameLabel);
    }];
    
    [_gradeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(15);
        make.left.equalTo(self.userNameLabel);
    }];
    
    [_starBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gradeTitle.mas_right).offset(5);
        make.centerY.equalTo(self.gradeTitle);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
    }];
    
    [_commentDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.gradeTitle.mas_bottom).offset(10);
        make.right.equalTo(self.timeLabel);
    }];
    
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.commentDetailLabel);
        make.top.equalTo(self.commentDetailLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.line.mas_top).offset(-10);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.right.bottom.equalTo(self);
    }];
    
}

- (CGFloat)getTextHeight:(NSString *)string{
    
    CGFloat w = SCREEN_WIDTH - ICON_W - 45;
    if (!StringIsNull(string)) {
        CGFloat height = [string boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
        return height;
    }
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
