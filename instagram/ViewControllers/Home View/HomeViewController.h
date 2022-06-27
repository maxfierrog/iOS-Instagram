//
//  HomeViewController.h
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ViewUtils.h"
#import "PostTableCell.h"
#import "PostFeedTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController
@property PFUser *currentUser;
@end

NS_ASSUME_NONNULL_END
