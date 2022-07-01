//
//  PostDetailsViewController.m
//  instagram
//
//  Created by maxfierro on 6/29/22.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *authorProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *authorUserName;
@property (weak, nonatomic) IBOutlet UILabel *postedTimeAgoLabel;
@property (weak, nonatomic) IBOutlet PFImageView *mainPostImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property NSArray *queryResult;
@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myPost = [self.delegate getPost];
    NSLog(@"%@", self.myPost);
    [self refreshDetails];
}

- (void)refreshDetails {
    self.authorUserName.text = self.myPost.postAuthor.username;
    self.postedTimeAgoLabel.text = [self.myPost.postTime timeAgoSinceNow];
    self.mainPostImage.file = self.myPost.postImage;
    self.postCaption.text = self.myPost.postCaption;
    self.postedTimeAgoLabel.textColor = [UIColor lightGrayColor];
    PFQuery *query = [UserData query];
    [query whereKey:@"user" equalTo:self.myPost.postAuthor.username];
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
    [self.mainPostImage loadInBackground];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
