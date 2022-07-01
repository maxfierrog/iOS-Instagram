//
//  UserModel.h
//  instagram
//
//  Created by maxfierro on 6/29/22.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserData : PFObject<PFSubclassing>
@property NSString *user;
@property PFFileObject *profilePicture;
+ (void) uploadProfilePicture:(UIImage * _Nullable)image withCompletion:(PFBooleanResultBlock _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image;
@end

NS_ASSUME_NONNULL_END
