//
//  GSLengthValidator.h
//  z24
//
//  Created by Gantulga on 29/12/2015.
//  Copyright © 2015 NNB. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <InputValidators/LKValidators.h>

typedef NS_ENUM(NSInteger, GSLengthValidatorType) {
    
    GSLengthValidatorTypeMoreThan,
    GSLengthValidatorTypeLessThan,
    GSLengthValidatorTypeEqual,
    GSLengthValidatorTypeRange,
};

@interface GSLengthValidator : LKValidator
@property (nonatomic, assign) GSLengthValidatorType validatorType;
@property (nonatomic, assign) NSUInteger length;
@property (nonatomic, assign) NSUInteger maxLength;

+ (instancetype)validatorMoreThanWithLength:(NSInteger) length ;

+ (instancetype)validatorLessThanWithLength:(NSInteger) length ;

+ (instancetype)validatorEqualWithLength:(NSInteger) length ;

+ (instancetype)validatorRangeWithMin:(NSInteger) length
                                  max:(NSInteger) maxLength;
@end
