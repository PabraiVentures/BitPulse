//
//  BPBTCPriceFetcher.h
//  BitPulse
//
//  Created by Nathan Pabrai on 9/9/14.
//  Copyright (c) 2014 Nathan Pabrai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPBTCPriceFetcher : NSObject <UIAlertViewDelegate>
+(NSDictionary*)getPrice;
@end
