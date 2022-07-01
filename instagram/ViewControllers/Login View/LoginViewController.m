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
}

- (IBAction)didTapLogin:(id)sender {
    UIAlertController *invalidValuesForLogin = [ViewUtils getAlertController:@"Please enter both a username and a password"
                                                                  warningHeader:@"Missing Credentials"
                                                                         action:^{}];
    if ([self canLogin]) {
        [self loginUser];
    } else {
        [self presentViewController:invalidValuesForLogin animated:YES completion:nil];
    }
}

- (IBAction)didTapRegister:(id)sender {
    UIAlertController *invalidValuesForRegister = [ViewUtils getAlertController:@"Please enter an email, username, and password"
                                                                  warningHeader:@"Missing Credentials"
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
    // FIXME: Strong reference to self in block of code below, how fix
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            UIAlertController *registerErrorAlert = [ViewUtils getAlertController:error.localizedDescription
                                                                          warningHeader:@"Login Error"
                                                                                 action:^{}];
            [self presentViewController:registerErrorAlert animated:YES completion:nil];
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
    // FIXME: Strong reference to self in block of code below, how fix
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            UIAlertController *loginErrorAlert = [ViewUtils getAlertController:error.localizedDescription
                                                                          warningHeader:@"Registration Error"
                                                                                 action:^{}];
            [self presentViewController:loginErrorAlert animated:YES completion:nil];
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [UserData uploadProfilePicture:[UIImage imageNamed:@"default-profile-picture"] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                [self segueToHomeFeed];
            }];
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

@end
