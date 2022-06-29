//
//  PostTableCell.h
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PFImageView.h"
#import "DateTools.h"
#import "PostModel.h"
#import "PostDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostTableCell : UITableViewCell
@property PostModel *myPost;
- (void)refreshCellContents;
- (PostModel *)getPost;
@end

NS_ASSUME_NONNULL_END
