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
@property NSArray *queryResult;
@end

@implementation PostTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
    self.authorProfilePicture.layer.cornerRadius = self.authorProfilePicture.frame.size.width / 2;
    self.authorProfilePicture.clipsToBounds = YES;
    PFQuery *query = [UserData query];
    [query whereKey:@"user" equalTo:self.authorUserName.text];
    [query orderByDescending:@"createdAt"];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray *dataRows, NSError *error) {
        if (error == nil) {
            self.queryResult = dataRows;
            NSLog(@"%@", self.queryResult);
            if (self.queryResult.count > 0) {
                UserData *result = self.queryResult[0];
                self.authorProfilePicture.file = result.profilePicture;
                self.authorProfilePicture.layer.cornerRadius = self.authorProfilePicture.frame.size.width / 2;
                self.authorProfilePicture.clipsToBounds = YES;
                [self.authorProfilePicture loadInBackground];
            } else {
                self.authorProfilePicture.file = nil;
            }
        }
    }];
    [self.postMainImage loadInBackground];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
