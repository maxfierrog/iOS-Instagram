//
//  ComposeViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "ComposeViewController.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *postCaptionField;
@property BOOL hasChosenImage;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapShare:(id)sender {
    UIAlertController *failedToSharePostAlert = [ViewUtils getAlertController:@"Please include both an image and caption for your post"
                                                                warningHeader:@"Post Invalid"
                                                                       action:^{}];
    if ([self cannotSharePost]) {
        [self presentViewController:failedToSharePostAlert animated:YES completion:nil];
    } else {
        [self sharePost];
    }
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapChooseImage:(id)sender {
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
    // UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    editedImage = [ViewUtils resizeImage:editedImage withSize:CGSizeMake(500.0f, 500.0f)];
    self.postImageView.image = editedImage;
    self.hasChosenImage = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sharePost {
    [Post postUserImage:self.postImageView.image withCaption:self.postCaptionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
    }];
    // Do this async?
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)cannotSharePost {
    // FIXME: Determine if the user has selected an image yet (bottom condition doesn't work)
    return !self.hasChosenImage || [self.postCaptionField.text isEqual:@""];
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
