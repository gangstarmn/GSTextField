//
//  GSTextField.h
//  z24
//
//  Created by Gantulga on 23/12/2015.
//  Copyright © 2015 NNB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InputValidators/LKValidators.h>

@interface GSTextField : UITextField
@property (nonatomic, assign) BOOL showErrorButton;
@property (nonatomic, strong) NSArray *validators;
-(BOOL) isValid;
@end
