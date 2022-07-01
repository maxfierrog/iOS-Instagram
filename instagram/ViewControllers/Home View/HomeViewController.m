//
//  HomeViewController.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property NSArray *postArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    UIRefreshControl *refreshControl = [ViewUtils getRefreshControl:self refreshSelector:@selector(refreshPostArray:) UIView:self.feedTableView];
    [self refreshPostArray:refreshControl];
}

- (IBAction)didTapLogOut:(id)sender {
    UIAlertController *logOutFailAlert = [ViewUtils getAlertController:@"Please try again later"
                                                         warningHeader:@"Error Logging Out"
                                                                action:^{}];
    // FIXME: Strong self reference
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

- (void)refreshPostArray:(UIRefreshControl *)refreshControl {
    PFQuery *query = [PostModel query];
    [query includeKey:@"postAuthor"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    // FIXME: Strong self reference
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = posts;
            [self.feedTableView reloadData];
        } else {
            UIAlertController *postLoadFailAlert = [ViewUtils getAlertController:error.localizedDescription
                                                                   warningHeader:@"Error Loading Feed"
                                                                          action:^{}];
            [self presentViewController:postLoadFailAlert animated:YES completion:nil];
        }
    }];
    [refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"PostTableCell"];
    postCell.myPost = self.postArray[indexPath.row];
    [postCell refreshCellContents];
    return postCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[PostTableCell class]]) {
        UINavigationController *navigationController = [segue destinationViewController];
        PostDetailsViewController *detailsVC = (PostDetailsViewController *)navigationController.topViewController;
        detailsVC.delegate = sender;
    }
}

@end
