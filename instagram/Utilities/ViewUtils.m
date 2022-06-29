//
//  ViewUtils.m
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import "ViewUtils.h"

@implementation ViewUtils

+ (UIAlertController *)getAlertController:(NSString *)warningText
                            warningHeader:(NSString *)warningHeader
                                   action:(void (^)(void))actionAfterOK {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:warningHeader
                                                                   message:warningText
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
        actionAfterOK();
    }];
    
    [alert addAction:ok];
    return alert;
}

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
