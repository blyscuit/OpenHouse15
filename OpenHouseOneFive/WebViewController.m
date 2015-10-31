//
//  WebViewController.m
//  OpenHouseOneFive
//
//  Created by Bliss Watchaye on 2015-10-30.
//  Copyright © 2015 Thinc. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:_idNumber ofType:@"html" inDirectory:@"V2"];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //NSString* htmlString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"21" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    //[_webView loadHTMLString:htmlString baseURL:baseURL];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:baseURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    
    return true;
}

@end
