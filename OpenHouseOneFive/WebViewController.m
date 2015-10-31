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
    // Do any additional setup after loading the view, typically from a nib.
    /*NSLog(@"Available font : %@",[UIFont familyNames]);
     NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"21" ofType:@"html"];
     NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
     //[_webView loadHTMLString:htmlFile baseURL:[[NSBundle mainBundle] bundlePath]];
     [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlFile isDirectory:YES]]];*/
    
    /*NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *homeIndexUrl = [mainBundle URLForResource:_idNumber withExtension:@"html"];
    
    // The magic is loading a request, *not* using loadHTMLString:baseURL:
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:homeIndexUrl];
    [_webView loadRequest:urlReq];
    
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.zoomScale = 1.0;
    _webView.scalesPageToFit = YES;*/
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"21" ofType:@"html" inDirectory:@"WebView"];
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
