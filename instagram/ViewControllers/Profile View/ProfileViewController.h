//
//  ProfileViewController.h
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UserData.h"
#import "PFImageView.h"
#import "ViewUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property UserData *user;
@end

NS_ASSUME_NONNULL_END
