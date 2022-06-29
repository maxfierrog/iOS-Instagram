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
    [self.mainPostImage loadInBackground];
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
