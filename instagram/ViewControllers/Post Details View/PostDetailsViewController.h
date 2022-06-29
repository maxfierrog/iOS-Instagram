//
//  PostDetailsViewController.h
//  instagram
//
//  Created by maxfierro on 6/29/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PFImageView.h"
#import "DateTools.h"
#import "PostModel.h"
#import "PostTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostDetailsDelegate <NSObject>
- (PostModel *)getPost;
@end

@interface PostDetailsViewController : UIViewController
@property PostModel *myPost;
@property (nonatomic, weak) id<PostDetailsDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
