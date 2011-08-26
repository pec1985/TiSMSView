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

-(void)_destroy
{
	// This method is called from the dealloc method and is good place to
	// release any objects and memory that have been allocated for the view proxy.
	RELEASE_TO_NIL(ourView);
	[super _destroy];
}

-(void)dealloc
{
	// This method is called when the view proxy is being deallocated. The superclass
	// method calls the _destroy method.

	[super dealloc];
}

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

-(void)blur:(id)args
{
	[[self ourView] _blur];
}

-(void)focus:(id)args
{
	[[self ourView] _focus];
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


-(UIImage *)returnImage:(id)arg
{
	UIImage *image = nil;
	if ([arg isKindOfClass:[UIImage class]]) 
	{
		image = (UIImage*)arg;
	}
	else if ([arg isKindOfClass:[TiBlob class]])
	{
		TiBlob *blob = (TiBlob*)arg;
		image = [blob image];
		
	}
/*	else if (image == nil) 
	{
		if ([arg isKindOfClass:[NSString class]])
		{
			NSLog(@"-=-=-= NSString -=--=-");
		}
		if ([arg isKindOfClass:[NSURL class]])
		{
			NSLog(@"-=-=-= NSURL -=--=-");
		}
		
	} else {
		image = [TiUtils image:arg proxy:self];
	}
*/
	else
	{
		NSLog(@"The image MUST be a blob.");
	}
	return image;
}

-(void)sendMessage:(id)args
{
	ENSURE_UI_THREAD(sendMessage,args);
	ENSURE_TYPE(args, NSArray);
	id arg = [args objectAtIndex:0];
	if([arg isKindOfClass:[NSString class]])
		[ourView sendMessage:arg];
	else
		[ourView sendImage:[self returnImage:arg]];
}

-(void)recieveMessage:(id)args
{
	ENSURE_UI_THREAD(recieveMessage,args);
	ENSURE_TYPE(args, NSArray);
	id arg = [args objectAtIndex:0];
	if([arg isKindOfClass:[NSString class]])
		[ourView recieveMessage:arg];
	else
		[ourView recieveImage:[self returnImage:arg]];
}

-(id)value
{
	return [[self ourView] value];
}
@end
