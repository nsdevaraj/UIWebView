//
//  SocialTangoViewController.m
//  WebViewer
//
//  Created by Devaraj NS on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialTangoViewController.h"

@implementation SocialTangoViewController
@synthesize webViewPhone; 
@synthesize webView;
@synthesize swiperG;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://socialtango.cognizant.com"]]];
    [webViewPhone loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://socialtango.cognizant.com"]]];
}

-(void) backHandler: (id)sender
{
    [self.webView goBack];
    [self.webViewPhone goBack];
}

-(void) forwardHandler: (id)sender
{
    [self.webView goForward];
    [self.webViewPhone goForward];
}

- (void)viewDidUnload
{
    [self setWebView:nil];  
    [self setSwiperG:nil]; 
    [self setWebViewPhone:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
//pad url handler
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [self urlHandler :[url absoluteString]:request];
        return NO;
    }
    return YES;
}

//phone url handler
- (BOOL)webViewPhone:(UIWebView*)webViewPhone shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
       [self urlHandler :[url absoluteString]:request];
        return NO;
    }
    return YES;
}

//common url handler for both device types
- (void)urlHandler:(NSString*)absoult :(NSURLRequest*)req
{
    //NSLog(@"url %lu %lu", (unsigned long)[absoult rangeOfString:@"socialtango"].location , (unsigned long)[absoult rangeOfString:@"https://cdn.embedly.com"].location);
    if ([absoult rangeOfString:@"socialtango"].location == NSNotFound && [absoult rangeOfString:@"embedly"].location == NSNotFound && [absoult rangeOfString:@"about:blank"].location == NSNotFound ) {
        //NSLog(@"url %@",absoult);
        [[UIApplication sharedApplication] openURL:req.URL];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    webView.delegate = self;
    webViewPhone.delegate = self;
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
} 
@end
