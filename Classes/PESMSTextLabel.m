//
//  PESMSTextLabel.m
//  textfield
//
//  Created by Pedro Enrique on 10/26/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PESMSTextLabel.h"

@implementation PESMSTextLabel
@synthesize index_;

-(void)dealloc
{
//	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];

	[super dealloc];
}

-(id)init
{
	if(self = [super init])
	{
	//	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resize:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
	}
	return self;
}

-(void)resize:(CGRect)frame
{
	if (![NSThread isMainThread])
		[self performSelectorOnMainThread:@selector(resize:) withObject:nil waitUntilDone:NO];

	float width = frame.size.width - 40;
		
	self.frame = CGRectMake(20, 0, width, 0);

	[self sizeToFit];
	
	CGRect a = self.frame;

	a.size.width = width;
	a.origin.x = 20;
	
	[self setFrame:a];

}

-(void)addText:(NSString *)text
{
	if (![NSThread isMainThread])
		[self performSelectorOnMainThread:@selector(addText:) withObject:text waitUntilDone:NO];
	self.text = text;
	self.font = [UIFont boldSystemFontOfSize:14];
	self.textColor = [UIColor grayColor];
	self.backgroundColor = [UIColor clearColor];
	self.textAlignment = UITextAlignmentCenter;
	self.numberOfLines = 0;
}

@end
