//
//  BPViewController.m
//  BitPulse
//
//  Created by Nathan Pabrai on 9/9/14.
//  Copyright (c) 2014 Nathan Pabrai. All rights reserved.
//

#import "BPViewController.h"
#import "BPBTCPriceFetcher.h"

@interface BPViewController ()
{
    IBOutlet UITextView *amount;
    IBOutlet UILabel *currency1;
    IBOutlet UILabel *currency2;
    NSDictionary* prices;
    IBOutlet UILabel *price;
    
    IBOutlet UIButton *usdSelection;//1
    IBOutlet UIButton *cnySelection;//2
    IBOutlet UIButton *gbpSelection;//3
    IBOutlet UIButton *eurSelection;//4
    IBOutlet UIButton *jpySelection;//5
    int currentSelection;
    BOOL invertPrice;
    IBOutlet ADBannerView *adView;
}

@end

@implementation BPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    prices = nil;
	// Do any additional setup after loading the view, typically from a nib.
    prices = [BPBTCPriceFetcher getPrice];
    currentSelection = 1;
    invertPrice = false;
    amount.delegate = self;
    if (prices)[self updateLabels];
    adView.delegate = self;
    adView.frame = CGRectMake(0, self.view.frame.size.height - adView.frame.size.height, self.view.frame.size.width, adView.frame.size.height);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)invertRates:(id)sender {
    invertPrice = !invertPrice;
   if(prices) [self updateLabels];
}

- (IBAction)currencySelected:(UIButton *)sender {
    if (sender == usdSelection) {
        currentSelection = 1;
    }
    if (sender == cnySelection) {
        currentSelection = 2;
    }
    if (sender == gbpSelection) {
        currentSelection = 3;
    }
    if (sender == eurSelection) {
        currentSelection = 4;
    }
    if (sender == jpySelection) {
        currentSelection = 5;
    }
  if (prices) [self updateLabels];
    
}
-(void) updateLabels{
    if (prices) {
        
    
    //based on currentSelection and invertPrice set the labels text
    if (invertPrice) {
        currency2.text = @"Bitcoin";
        switch (currentSelection) {
            case 1:
                currency1.text=@"US Dollars";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"usd_to_btc"]).floatValue * amount.text.floatValue];
                break;
            case 2:
                currency1.text=@"Chinese Yuan";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"cny_to_btc"]).floatValue * amount.text.floatValue];
                break;
            case 3:
                currency1.text=@"Pound Sterling";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"gbp_to_btc"]).floatValue * amount.text.floatValue];
                break;
            case 4:
                currency1.text=@"Euro";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"eur_to_btc"]).floatValue * amount.text.floatValue];
                break;
            case 5:
                currency1.text=@"Japanese Yen";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"jpy_to_btc"]).floatValue * amount.text.floatValue];
                break;
            default:
                currentSelection=1;
                currency1.text=@"US Dollars";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"usd_to_btc"]).floatValue * amount.text.floatValue];
                break;
        }
    }
    else  {
        currency1.text = @"Bitcoin";
        switch (currentSelection) {
            case 1:
                currency2.text=@"US Dollars";
                 price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_usd"]).floatValue * amount.text.floatValue];
                break;
            case 2:
                currency2.text=@"Chinese Yuan";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_cny"]).floatValue * amount.text.floatValue];
                break;
            case 3:
                currency2.text=@"Pound Sterling";
                 price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_gbp"]).floatValue * amount.text.floatValue];
                break;
            case 4:
                currency2.text=@"Euro";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_eur"]).floatValue * amount.text.floatValue];
                break;
            case 5:
                currency2.text=@"Japanese Yen";
                price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_jpy"]).floatValue * amount.text.floatValue];
                break;
            default:
                currentSelection=1;
                currency2.text=@"US Dollars";
                 price.text = [NSString stringWithFormat:@"%f",((NSString*)[prices objectForKey:@"btc_to_usd"]).floatValue * amount.text.floatValue];
                break;
        }
    }
    }
}

//UITextView protocol methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    if ([amount isFirstResponder] && [touch view] != amount) {
        
        amount.text = amount.text.floatValue? [NSString stringWithFormat:@"%.4f", amount.text.floatValue]: @"0";
        [self updateLabels];
        [amount resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

//Ad BannerView protocol methods

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"bannerview did not receive any banner due to %@", error);}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner{//NSLog(@"bannerview was selected");}
}


- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{return true;}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {//NSLog(@"banner was loaded");}
}

@end
