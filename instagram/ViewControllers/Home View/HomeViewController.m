//
//  HomeViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

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
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            self.view.window.rootViewController = loginViewController;
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // FIXME: Get number of posts to load
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostTableCell"];
    // FIXME: idk yet
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
