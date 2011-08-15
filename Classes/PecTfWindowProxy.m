//
//  PecTfWindowProxy.m
//  textfield
//
//  Created by Pedro Enrique on 8/14/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PecTfWindowProxy.h"
#import "TiComplexValue.h"

@implementation PecTfWindowProxy

-(PEChatWindow *)win
{
	if(!win)
	{
		if(modalFlag)
			typeOfWindow = @"modal";
		if(navWindow)
			typeOfWindow = @"nav";
		if(fullscreenFlag)
			typeOfWindow = @"full";
			
		win = [[PEChatWindow alloc] init];
		[win typeOfWindow:typeOfWindow];
		[win setParent:self];
		
		win.view.frame = self.view.frame;
		[self.view addSubview:win.view];
	}
	return win;
}

-(void)setupWindowDecorations
{
}

-(void)windowWillOpen
{
	win = [self win];
}

-(void)sendMessage:(id)message
{
	ENSURE_SINGLE_ARG(message,NSDictionary);

	NSString *a = [[NSString alloc] initWithFormat:@"%@",[message objectForKey:@"message"]];
	
	[[self win] sendMessage:@"lalala"];

	NSLog(@"%@", a);
	
}

-(void)recieveMessage:(id)message
{
	ENSURE_SINGLE_ARG(message,NSDictionary);

	[[self win] recieveMessage:[message objectForKey:@"message"]];
}


@end
