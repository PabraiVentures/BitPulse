//
//  BPBTCPriceFetcher.m
//  BitPulse
//
//  Created by Nathan Pabrai on 9/9/14.
//  Copyright (c) 2014 Nathan Pabrai. All rights reserved.
//

#import "BPBTCPriceFetcher.h"

@implementation BPBTCPriceFetcher
+(NSDictionary*) getPrice{
    @try {
        return [BPBTCPriceFetcher makeBitcoinCall];

    }
    @catch (NSException *exception) {
       UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"There was a connection error please retry later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }

  }

+(NSDictionary*) makeBitcoinCall{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://coinbase.com/api/v1/currencies/exchange_rates"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    //NSLog(@"output of the --- request --- is : \n%@", ([response1 length] > 0)?[NSString stringWithUTF8String:[response1 bytes]]: @"emptystring");
    NSString *responseString = [NSString stringWithUTF8String:[response1 bytes]];
    NSError *e;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData: [responseString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options: NSJSONReadingMutableContainers
                                                           error: &e];
    /* TESTING OUTPUT
     NSLog(@"THE USD PRICE: %@", [data valueForKey:@"usd_to_btc"]);
     NSLog(@"THE EUR PRICE: %@", [data valueForKey:@"eur_to_btc"]);
     NSLog(@"THE GBP PRICE: %@", [data valueForKey:@"gbp_to_btc"]);
     NSLog(@"THE CNY PRICE: %@", [data valueForKey:@"cny_to_btc"]);
     NSLog(@"THE USD PRICE: %@", [data valueForKey:@"jpy_to_btc"]);
     
     NSLog(@"THE 1/USD PRICE: %@", [data valueForKey:@"btc_to_usd"]);
     NSLog(@"THE 1/EUR PRICE: %@", [data valueForKey:@"btc_to_eur"]);
     NSLog(@"THE 1/GBP PRICE: %@", [data valueForKey:@"btc_to_gbp"]);
     NSLog(@"THE 1/USD PRICE: %@", [data valueForKey:@"btc_to_cny"]);
     NSLog(@"THE 1/CNY PRICE: %@", [data valueForKey:@"btc_to_jpy"]);
     */
    return data;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

}
@end
