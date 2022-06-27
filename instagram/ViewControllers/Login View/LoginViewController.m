//
//  LoginViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ViewUtils.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogin:(id)sender {
    UIAlertController *invalidValuesForLogin = [ViewUtils getAlertController:@"Please enter a valid username and password"
                                                                  warningHeader:@"Couldn't Log In"
                                                                         action:^{}];
    if ([self canLogin]) {
        [self loginUser];
    } else {
        [self presentViewController:invalidValuesForLogin animated:YES completion:nil];
    }
}

- (IBAction)didTapRegister:(id)sender {
    UIAlertController *invalidValuesForRegister = [ViewUtils getAlertController:@"Please enter a valid email, username, and password"
                                                                  warningHeader:@"Couldn't Register User"
                                                                         action:^{}];
    if ([self canRegister]) {
        [self registerUser];
    } else {
        [self presentViewController:invalidValuesForRegister animated:YES completion:nil];
    }
}

- (void)loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self segueToHomeFeed];
        }
    }];
}

- (void)registerUser {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self segueToHomeFeed];
        }
    }];
}

- (void)segueToHomeFeed {
    [self performSegueWithIdentifier:@"exitLoginScreen" sender:nil];
}

- (BOOL)canLogin {
    return ![self.usernameTextField.text isEqual:@""] && ![self.passwordTextField.text isEqual:@""];
}

- (BOOL)canRegister {
    return ![self.emailTextField.text isEqual:@""] && [self canLogin];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Fine as empty.
}

@end
