//
//  Post.h
//  instagram
//
//  Created by maxfierro on 6/28/22.
//

#import <Parse/Parse.h>
#import "UserData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostModel : PFObject<PFSubclassing>
@property PFUser *postAuthor;
@property PFFileObject *postImage;
@property NSString *postCaption;
@property NSDate *postTime;
@property NSString *postID;
@property NSString *userID;
+ (void) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption withCompletion:(PFBooleanResultBlock _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image;
@end

NS_ASSUME_NONNULL_END
