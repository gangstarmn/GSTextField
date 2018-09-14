//
//  UIImage+Bundle.h
//  DBCamera
//
//  Created by Dongyuan Liu on 2015-07-15.
//  Copyright (c) 2015 PSSD - Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GSBundle)

/**
 *  Returns an image in current bundle, compatible with framework
 *
 *  @param name The name of the image
 *
 *  @return An UIImage
 */
+ (UIImage *)imageInGSBundleNamed:(NSString *)name;

@end
