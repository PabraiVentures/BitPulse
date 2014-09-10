//
//  BPViewController.h
//  BitPulse
//
//  Created by Nathan Pabrai on 9/9/14.
//  Copyright (c) 2014 Nathan Pabrai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface BPViewController : UIViewController <UITextViewDelegate, ADBannerViewDelegate>
- (IBAction)invertRates:(id)sender;
- (IBAction)currencySelected:(UIButton *)sender;

@end
