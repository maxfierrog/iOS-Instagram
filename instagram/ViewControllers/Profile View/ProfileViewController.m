//
//  ProfileViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *userProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSArray *queryResult;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUIContents];
}

// FIXME: A lot of the code below is repeated from ComposeViewController.m
- (IBAction)didTapProfilePicture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    editedImage = [ViewUtils resizeImage:editedImage withSize:CGSizeMake(200.0f, 200.0f)];
    self.userProfilePicture.image = editedImage;
    [self pushProfilePicture];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshUIContents {
    self.titleLabel.text = [[PFUser currentUser].username stringByAppendingString:@"'s profile"];
    [self pullProfilePicture];
}

- (void)pushProfilePicture {
    [UserData uploadProfilePicture:self.userProfilePicture.image withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self refreshUIContents];
        } else {
            UIAlertController *pictureUploadFailAlert = [ViewUtils getAlertController:error.localizedDescription
                                                                   warningHeader:@"Error uploading profile picture"
                                                                          action:^{}];
            [self presentViewController:pictureUploadFailAlert animated:YES completion:nil];
        }
    }];
}

- (void)pullProfilePicture {
    PFQuery *query = [UserData query];
    [query whereKey:@"user" equalTo:[PFUser currentUser].username];
    [query orderByDescending:@"createdAt"];
    query.limit = 1;
    [query findObjectsInBackgroundWithBlock:^(NSArray *dataRows, NSError *error) {
        if (error == nil) {
            self.queryResult = dataRows;
            if (self.queryResult.count > 0) {
                UserData *result = self.queryResult[0];
                NSLog(@"%@", result);
                NSLog(@"%@", result.profilePicture);
                self.userProfilePicture.file = result.profilePicture;
                self.userProfilePicture.layer.cornerRadius = self.userProfilePicture.frame.size.width / 2;
                self.userProfilePicture.clipsToBounds = YES;
                [self.userProfilePicture loadInBackground];
            } else {
                self.userProfilePicture.file = nil;
            }
        } else{
            UIAlertController *picturePullFailAlert = [ViewUtils getAlertController:error.localizedDescription
                                                                   warningHeader:@"Error fetching profile picture"
                                                                          action:^{}];
            [self presentViewController:picturePullFailAlert animated:YES completion:nil];
        }
    }];
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
