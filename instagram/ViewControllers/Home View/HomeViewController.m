//
//  HomeViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "HomeViewController.h"
#import "ViewUtils.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = PFUser.currentUser;
}

- (IBAction)didTapLogOut:(id)sender {
    UIAlertController *logOutFailAlert = [ViewUtils getAlertController:@"Please try again later"
                                                         warningHeader:@"Error Logging Out"
                                                                action:^{}];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Failed to log out user");
            [self presentViewController:logOutFailAlert animated:YES completion:nil];
        } else {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
            // FIXME: this is not working ^
        }
    }];
}

- (IBAction)didTapCompose:(id)sender {
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
