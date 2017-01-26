//
//  GSTextField.m
//  z24
//
//  Created by Gantulga on 23/12/2015.
//  Copyright © 2015 NNB. All rights reserved.
//

#import "GSTextField.h"
#import "GSNameValidator.h"
#import "GSLengthValidator.h"
#import "UIImage+Bundle.h"
#import <SCViewShaker/UIView+Shake.h>
#import <GSLocalization/GSLocalization.h>

@interface GSTextField () {
    BOOL isExpanded;
}

@property (nonatomic, strong) UIView *errorView;
@property (nonatomic, strong) UIButton *errorButton;
@property (nonatomic, strong) UIImageView *errorBGImageView;
@property (nonatomic, strong) UILabel *errorLabel;

@end

@implementation GSTextField
static UIColor *errorTextColor = nil;
static UIColor *mainTintColor = nil;
static UIFont *errorTextFont = nil;


static NSString *bundleName = @"GSTextField";

#ifndef GSTextFieldLocalizedString
#define GSTextFieldLocalizedString(key) \
GSLocalizedString((key), bundleName)
#endif

- (UIColor *)errorTextColor {
    if (!errorTextColor) errorTextColor = [UIColor whiteColor];
    return errorTextColor;
}

- (void)setErrorTextColor :(UIColor *)color{
    errorTextColor = color;
    self.errorLabel.textColor = errorTextColor;
}

- (UIColor *)mainTintColor {
    if (!mainTintColor) mainTintColor = [UIColor redColor];
    return mainTintColor;
}

//- (void)setMainTintColor :(UIColor *)color{
//    mainTintColor = color;
//    self.errorBGImageView.tintColor = mainTintColor;
//    self.errorButton.tintColor = mainTintColor;
//}

- (void) initDefaultValues {
    
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, self.errorBGImageView.bounds.size.width-10, self.errorBGImageView.bounds.size.height-4)];
        _errorLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _errorLabel.clipsToBounds = YES;
        _errorLabel.font = [UIFont systemFontOfSize:14];
        _errorLabel.textColor = [self errorTextColor];
    }
    return _errorLabel;
}
- (UIImageView *)errorBGImageView {
    if (!_errorBGImageView) {
        _errorBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, self.errorView.bounds.size.width-self.errorView.bounds.size.height-3, self.bounds.size.height-4)];
        UIImage *errorBGImage = [[UIImage imageInBundleNamed:@"bs_errorBG"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        _errorBGImageView.image = errorBGImage;
        _errorBGImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _errorBGImageView.tintColor = [self mainTintColor];
        _errorBGImageView.clipsToBounds = YES;
        [_errorBGImageView addSubview:self.errorLabel];
    }
    return _errorBGImageView;
}
- (UIButton *)errorButton {
    if (!_errorButton) {
        _errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_errorButton setImage:[UIImage imageInBundleNamed:@"bs_errorIcon"] forState:UIControlStateNormal];
        _errorButton.tintColor = [self mainTintColor];
        _errorButton.frame = CGRectMake(self.errorView.bounds.size.width-self.errorView.bounds.size.height, 0, self.errorView.bounds.size.height, self.errorView.bounds.size.height);
        [_errorButton addTarget:self action:@selector(errorButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _errorButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    return _errorButton;
}
- (UIView *)errorView {
    if (!_errorView) {
        _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height+20, self.bounds.size.height)];
        [_errorView addSubview:self.errorButton];
        [_errorView addSubview:self.errorBGImageView];
    }
    return _errorView;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.rightView = self.errorView;
        self.errorView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        isExpanded = false;
        [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self errorView];
        self.rightView = self.errorView;
        self.errorView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        isExpanded = false;
        [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)errorButtonAction{
    if (isExpanded) {
        isExpanded = false;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.errorView.frame;
            frame.size.width = self.bounds.size.height;
            frame.origin.x = self.bounds.size.width - frame.size.width;
            self.errorView.frame = frame;
        }];
    }
    else {
        
        CGSize size = [self.errorLabel.text sizeWithAttributes:@{NSFontAttributeName:self.errorLabel.font}];
        if ((size.width + self.bounds.size.height + 10 > self.bounds.size.width)) {
            [[[UIAlertView alloc] initWithTitle:@"" message:self.errorLabel.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            return;
        }
        
        
        isExpanded = true;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.errorView.frame;
            frame.size.width = size.width + self.bounds.size.height + 10;
            frame.origin.x = self.bounds.size.width - frame.size.width;
            self.errorView.frame = frame;
        }];
    }
}
- (void)setShowErrorButton:(BOOL)showErrorButton {
    _showErrorButton = showErrorButton;
    if (_showErrorButton) {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.errorView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    }
    else {
        self.rightViewMode = UITextFieldViewModeNever;
        self.errorView.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    }
}

- (void) textDidChange :(UITextField *)textField {
    self.showErrorButton = ![self isValid];
}
- (UIView *)shakeView {
    if (!_shakeView) {
        _shakeView = self.superview;
    }
    return _shakeView;
}
-(BOOL) isValid  {
    BOOL isValid = YES;

    NSError *error = nil;
    
    for (LKValidator *validator in self.validators) {
        if (![validator validate:self.text error:&error]) {
            //            self.errorLabel.text = error.localizedFailureReason;
            isValid = YES;
            if ([validator isKindOfClass:[LKRequiredValidator class]]) {
                isValid = NO;
                self.errorLabel.text = GSTextFieldLocalizedString(@"error.required");
            }
            else if ([validator isKindOfClass:[LKAlphaValidator class]]) {
                if (self.text.length > 0) {
                    isValid = NO;
                    self.errorLabel.text = GSTextFieldLocalizedString(@"error.letter");
                }
            }
            else if ([validator isKindOfClass:[GSNameValidator class]]) {
                if (self.text.length > 0) {
                    isValid = NO;
                    self.errorLabel.text = GSTextFieldLocalizedString(@"error.letter.hyphen");
                }
            }
            else if ([validator isKindOfClass:[LKEmailValidator class]]) {
                if (self.text.length > 0) {
                    isValid = NO;
                    self.errorLabel.text = GSTextFieldLocalizedString(@"error.email");
                }
            }
            else if ([validator isKindOfClass:[LKNumericValidator class]]) {
                if (self.text.length > 0) {
                    isValid = NO;
                    self.errorLabel.text = GSTextFieldLocalizedString(@"error.number");
                }
            }
            else if ([validator isKindOfClass:[LKLengthValidator class]]) {
                if (self.text.length > 0) {
                    isValid = NO;
                    self.errorLabel.text = GSTextFieldLocalizedString(@"error.min.length");
                }
            }
            else if ([validator isKindOfClass:[GSLengthValidator class]]) {
                
                if (self.text.length > 0) {
                    
                    isValid = NO;
                    
                    GSLengthValidator *lenghtValidator = (GSLengthValidator *)validator;
                    if (lenghtValidator.validatorType == GSLengthValidatorTypeMoreThan) {
                        self.errorLabel.text = [NSString stringWithFormat:GSTextFieldLocalizedString(@"error.length.morethan"),lenghtValidator.length];
                    }
                    else if (lenghtValidator.validatorType == GSLengthValidatorTypeLessThan) {
                        self.errorLabel.text = [NSString stringWithFormat:GSTextFieldLocalizedString(@"error.length.lessthan"),lenghtValidator.length];
                    }
                    else if (lenghtValidator.validatorType == GSLengthValidatorTypeEqual) {
                        self.errorLabel.text = [NSString stringWithFormat:GSTextFieldLocalizedString(@"error.length.equal"),lenghtValidator.length];
                    }
                    else if (lenghtValidator.validatorType == GSLengthValidatorTypeRange) {
                        self.errorLabel.text = [NSString stringWithFormat:GSTextFieldLocalizedString(@"error.length.range"),lenghtValidator.length,lenghtValidator.maxLength];
                    }
                }
            }
            else {
                isValid = NO;
                self.errorLabel.text = GSTextFieldLocalizedString(@"error.error");

                self.errorLabel.text = @"Error";
            }
            
            if (!isValid) {
                break;
            }
        }
    }
    return isValid;
}

-(BOOL) checkValid {
    if (![self isValid]) {
        [self.shakeView shakeWithOptions:SCShakeOptionsDirectionHorizontal force:0.01 duration:0.5 iterationDuration:0.03 completionHandler:nil];
        return false;
    }
    return true;
}

@end
