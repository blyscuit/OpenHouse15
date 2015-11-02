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
    NSArray *facultyNameArr = [NSArray arrayWithObjects:@"วิศวกรรมศาสตร์",@"อักษรศาสตร์",@"วิทยาศาสตร์",@"รัฐศาสตร์",@"สถาปัตยกรรมศาสตร์",@"พาณิชยศาสตร์ และการบัญชี",@"ครุศาสตร์",@"นิเทศศาสตร์",@"เศรษฐศาสตร์",@"แพทยศาสตร์",@"สัตวแพทยศาสตร์",@"ทันตแพทยศาสตร์",@"เภสัชศาสตร์",@"นิติศาสตร์",@"ศิลปกรรมศาสตร์",@"พยาบาลไม่มีนะจ้า",@"สหเวชศาสตร์",@"จิตวิทยา",@"วิทยาศาสตร์การกีฬา",@"สำนักวิชาทรัพยากรการเกษตร", nil];
    int i = [_idNumber intValue] - 21;
    self.navigationItem.title = facultyNameArr[i];
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
