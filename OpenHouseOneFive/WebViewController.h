//
//  WebViewController.h
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-30.
//  Copyright © 2015 Thinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong) NSString*idNumber;

@end
