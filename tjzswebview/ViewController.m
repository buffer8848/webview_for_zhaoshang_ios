//
//  ViewController.m
//  tjzswebview
//
//  Created by buffer on 14-7-10.
//  Copyright (c) 2014年 com.Intel.Avatar. All rights reserved.
//

#import "ViewController.h"

#define MAIN_URL @"http://www.zhaoshang.net/m/redirect.php"
#define COOKIE_DATA @"cookie.data"

@interface ViewController ()
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect rect = self.view.bounds;
    rect.origin.y = 18;
    webView = [[UIWebView alloc] initWithFrame:rect];
    [webView setDelegate:self];
    [self.view addSubview: webView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:MAIN_URL]];
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *file = [Path stringByAppendingPathComponent:COOKIE_DATA];
    NSArray *cookies = [[NSArray alloc] initWithContentsOfFile:file];
    NSDictionary *	headers = [NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
    [request setAllHTTPHeaderFields:headers];
    //NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dic_cookies];
    //[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    // [request addValue:[dic_cookies valueForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//---------------------------------------------------------------------------------------------------
//common functions
-(void)stop_indicator
{
    if ([activityIndicator isAnimating])
    {
        [activityIndicator stopAnimating];
        UIView *view = (UIView*)[self.view viewWithTag:108];
        [view removeFromSuperview];
    }
}

//---------------------------------------------------------------------------------------------------
//touch event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self stop_indicator];
}

//---------------------------------------------------------------------------------------------------
//webview delegete
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 64.0f, 64.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self stop_indicator];
    
    //process cookie
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //NSDictionary *dic_cookies = [NSHTTPCookie requestHeaderFieldsWithCookies:nCookies];
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *file = [Path stringByAppendingPathComponent:COOKIE_DATA];
    [nCookies writeToFile:file atomically:YES];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

@end
