//
//  ViewUtils.h
//  instagram
//
//  Created by maxfierro on 6/27/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewUtils : NSObject

+ (UIAlertController *)getAlertController:(NSString *)warningText
                            warningHeader:(NSString *)warningHeader
                                   action:(void (^)(void))actionAfterOK;
+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
