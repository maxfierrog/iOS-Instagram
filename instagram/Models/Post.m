//
//  Post.m
//  instagram
//
//  Created by maxfierro on 6/28/22.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic postAuthor;
@dynamic postCaption;
@dynamic postTime;
@dynamic postImage;
@dynamic userID;

+ (void) postUserImage:(UIImage * _Nullable)image withCaption:(NSString * _Nullable)caption withCompletion:(PFBooleanResultBlock _Nullable)completion {
 Post *newPost = [Post new];
 newPost.postImage = [self getPFFileFromImage:image];
 newPost.postAuthor = [PFUser currentUser];
 newPost.postCaption = caption;
 [newPost saveInBackgroundWithBlock:completion];
}

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
    return @"Post";
}

@end
