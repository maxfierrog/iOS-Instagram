//
//  UserModel.m
//  instagram
//
//  Created by maxfierro on 6/29/22.
//

#import "UserData.h"

@implementation UserData

@dynamic user;
@dynamic profilePicture;

+ (void) uploadProfilePicture:(UIImage * _Nullable)image withCompletion:(PFBooleanResultBlock _Nullable)completion {
    UserData *user = [UserData new];
    user.profilePicture = [self getPFFileFromImage:image];
    user.user = [PFUser currentUser].username;
    [user saveInBackgroundWithBlock:completion];
}

// FIXME: Utils this function away
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
     if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

+ (nonnull NSString *)parseClassName {
    return @"UserData";
}

@end
