//
//  ProfileViewController.h
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property PFUser *currentUser;
@end

NS_ASSUME_NONNULL_END