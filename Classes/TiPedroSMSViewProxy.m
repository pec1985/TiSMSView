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
#import "UIImage+Resize.h"

@implementation TiPedroSMSViewProxy

-(void)_destroy
{
	// This method is called from the dealloc method and is good place to
	// release any objects and memory that have been allocated for the view proxy.
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
	[self retain];
	[super viewDidAttach];
}

-(void)viewDidDetach
{
	[self autorelease];
	[super viewDidDetach];
}

-(void)blur:(id)args
{
	ENSURE_UI_THREAD(blur, args);
	[[self ourView] _blur];
}

-(void)focus:(id)args
{
	ENSURE_UI_THREAD(focus, args);
	[[self ourView] _focus];
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
	else
	{
		NSLog(@"[WARN] The image MUST be a blob.");
		NSLog(@"[WARN]");
		NSLog(@"[WARN] This is a workaround:");
		NSLog(@"[WARN]");
		NSLog(@"[WARN] var img = Ti.UI.createImageView({image:'whatever.png'}).toImage();");
		NSLog(@"[WARN] xx.sendMessage(img);");
		NSLog(@"[WARN]      or");
		NSLog(@"[WARN] xx.recieveMessage(img);");
		NSLog(@"[WARN]");
	}
		
	if(image != nil)
	{
		CGSize imageSize = image.size;		
		if(imageSize.width > [[self ourView] superview].frame.size.width-100)
		{
			float x = ([[self ourView] superview].frame.size.width-100);
			float y = ((x/imageSize.width)*imageSize.height);
			CGSize newSize = CGSizeMake(x, y);
			image = [UIImageResize resizedImage:newSize interpolationQuality:kCGInterpolationDefault image:image  hires:YES];
		}
		
	}		
	
	return image;
}

-(void)empty:(id)args
{
	ENSURE_UI_THREAD(empty, args);
	[ourView empty];
}

-(void)sendMessage:(id)args
{
	ENSURE_UI_THREAD(sendMessage,args);
	ENSURE_TYPE(args, NSArray);
	id arg = [args objectAtIndex:0];
	if([arg isKindOfClass:[NSString class]])
		[ourView sendMessage:arg];
	else if ([arg isKindOfClass:[TiViewProxy class]])
	{
		TiViewProxy *a = arg;
		[ourView sendImageView:a.view];
	}
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
	else if ([arg isKindOfClass:[TiViewProxy class]])
	{
		TiViewProxy *a = arg;
		[ourView recieveImageView:a.view];
	}
	else
		[ourView recieveImage:[self returnImage:arg]];
}

-(void)loadMessages:(id)args
{
	ENSURE_SINGLE_ARG(args,NSArray);
	for(int i = 0; i < [args count]; i++)
	{
		id obj = [args objectAtIndex:i];
		ENSURE_SINGLE_ARG(obj, NSObject);
		if([obj objectForKey:@"send"])
		{
			[self sendMessage: [NSArray arrayWithObject:[obj objectForKey:@"send"]]];
		}
		if([obj objectForKey:@"recieve"])
		{
			[self recieveMessage: [NSArray arrayWithObject:[obj objectForKey:@"recieve"]]];
		}
	}
}

-(NSArray *)getAllMessages:(id)arg
{
	return [ourView getMessages];
}

-(id)value
{
	return [[self ourView] value];
}
@end
