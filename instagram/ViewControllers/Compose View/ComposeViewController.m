//
//  ComposeViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *postCaptionField;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapShare:(id)sender {
    UIAlertController *failedToSharePostAlert = [ViewUtils getAlertController:@"Please include an image for your post"
                                                                warningHeader:@"Post Invalid"
                                                                       action:^{}];
    if ([self canSharePost]) {
        [self sharePost];
        NSLog(@"Success sharing post");
    } else {
        NSLog(@"Failed to share post");
        [self presentViewController:failedToSharePostAlert animated:YES completion:nil];
    }
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)sharePost {
    
}

- (BOOL)canSharePost {
    // FIXME: Determine if the user has selected an image yet (bottom condition doesn't work)
    return ![self.postImageView.image isEqual:nil] && ![self.postCaptionField.text isEqual:@""];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
