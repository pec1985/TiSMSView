//
//  PecTfTextFieldProxy.m
//  textfield
//
//  Created by Pedro Enrique on 7/3/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "TiPedroSMSView.h"
#import "TiPedroSMSViewProxy.h"
#import "TiUtils.h"

@implementation TiPedroSMSViewProxy

-(TiPedroSMSView *)ourView
{
	if(!ourView)
	{
		ourView = (TiPedroSMSView *)[self view];
	}
	return ourView;
}

-(void)viewDidAttach
{
	[[NSNotificationCenter defaultCenter] addObserver:[self ourView] 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:[self ourView] 
											 selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification 
											   object:nil];	
	[super viewDidAttach];
}

-(void)message:(id)args
{
	ENSURE_SINGLE_ARG(args,NSDictionary);
	NSString *send = [args objectForKey:@"send"]?[args objectForKey:@"send"]:@"";
	NSString *recieve = [args objectForKey:@"recieve"]?[args objectForKey:@"recieve"]:@"";
	if(![send isEqualToString:@""]){
		
		[ourView sendMessage:send];
	}
	if(![recieve isEqualToString:@""])
		[ourView recieveMessage:recieve];
}

-(void)sendMessage:(id)args
{
	ENSURE_SINGLE_ARG(args, NSString);
	[ourView sendMessage:args];
}

-(void)recieveMessage:(id)args
{
	ENSURE_SINGLE_ARG(args, NSString);
	[ourView recieveMessage:args];
	
}

-(id)value
{
	return [[self ourView] value];
}
@end
