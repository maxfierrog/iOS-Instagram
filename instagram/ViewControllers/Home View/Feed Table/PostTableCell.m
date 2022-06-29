//
//  PostTableCell.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "PostTableCell.h"

@interface PostTableCell () <PostDetailsDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *authorProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *authorUserName;
@property (weak, nonatomic) IBOutlet UILabel *postedThisLongAgoLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postMainImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@end

@implementation PostTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self refreshCellContents];
}

- (PostModel *)getPost {
    return self.myPost;
}

- (void)refreshCellContents {
    self.authorUserName.text = self.myPost.postAuthor.username;
    self.postedThisLongAgoLabel.text = [self.myPost.postTime timeAgoSinceNow];
    self.postMainImage.file = self.myPost.postImage;
    self.postCaption.text = self.myPost.postCaption;
    self.postedThisLongAgoLabel.textColor = [UIColor lightGrayColor];
    [self.postMainImage loadInBackground];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
