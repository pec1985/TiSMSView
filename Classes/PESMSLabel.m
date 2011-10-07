//
//  Label.m
//  chat
//
//  Created by Pedro Enrique on 8/13/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PESMSLabel.h"
#import "TiHost.h"

@implementation PESMSLabel

@synthesize rColor;
@synthesize sColor;
@synthesize isText;
@synthesize isImage;
@synthesize isView;
@synthesize thisPos;
@synthesize thisColor;
@synthesize selectedColor;
@synthesize textValue;
@synthesize innerView;
@synthesize folder;
@synthesize imageValue;
@synthesize prox;
@synthesize index_;
@synthesize orient;

-(void)dealloc
{
	if(self.isText)
		RELEASE_TO_NIL(label);
	if(self.isImage)
		RELEASE_TO_NIL(innerImage);
	if(self.isView)
		RELEASE_TO_NIL(innerView);
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];

	[super dealloc];
}

-(id)init
{
	if(self = [super init])
	{
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
	}
	return self;
}


- (void)doLongTouch
{
	[self becomeFirstResponder];
	UIMenuController *menu = [UIMenuController sharedMenuController];
	[menu setTargetRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height) inView:self];
	[menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder;
{
	return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;
{
	BOOL r = NO;
	if (action == @selector(copy:)) {
		r = YES;
	} else {
		r = [super canPerformAction:action withSender:sender];
	}
	return r;
}

- (void)copy:(id)sender
{
	UIPasteboard *paste = [UIPasteboard generalPasteboard];
	paste.persistent = YES;
	[paste setString:self.textValue];	
}

- (void)orientationChanged:(NSNotification *)note
{
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	
	if (orientation == UIDeviceOrientationLandscapeLeft ||
		orientation == UIDeviceOrientationLandscapeRight ||
		orientation == UIDeviceOrientationPortrait ||
		orientation == UIDeviceOrientationPortraitUpsideDown)
	{
		if(orientation != orient && [self.thisPos isEqualToString:@"Right"])
		{
			CGRect a = self.frame;
			a.origin.x = (self.superview.frame.size.width-self.frame.size.width)-5;
			[self setFrame:a];
			[self setNeedsDisplay];
			orient = orientation;
		}
	}

}

-(UIImageView *)innerImage:(UIImage *)image
{
	if(!innerImage)
	{
		innerImage = [[UIImageView alloc] initWithImage:image];
		self.isImage = YES;
	}
	return innerImage;
}

-(UILabel *)label
{
	if(!label)
	{
		hold = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doLongTouch)];
		[self addGestureRecognizer:hold];
		[hold release];
		label = [[UILabel alloc] init];
		label.numberOfLines = 0;
		label.backgroundColor = [UIColor clearColor];
		self.isText = YES;
	}
	return label;
}

-(void)setUpTextImageSize
{
	CGRect x = [self label].frame;
	if(x.size.width > 270)//self.superview.frame.size.width-100)
	{
		x.size.width = 270;//self.superview.frame.size.width-100;
		[[self label] setFrame:x];
		[[self label] sizeToFit];
		
	}
	CGRect a = [self label].frame;
	a.size.width +=25;
	a.size.height +=10;
	a.origin.y = 10;
	a.origin.x = 5;
	self.frame = a;
	
	CGRect b = [self label].frame;
	b.origin.y = 3;
	b.origin.x = 15;
	[[self label] setFrame:b];
}

-(void)setUpInnerImageImageSize
{
	CGRect a = [self innerImage:nil].frame;
	a.size.width +=25;
	a.size.height +=20;
	a.origin.y = 10;
	a.origin.x = 10;
	self.frame = a;
	
	CGRect b = [self innerImage:nil].frame;
	b.origin.y = 8;	
	b.origin.x = 15;
	
	[[self innerImage:nil] setFrame:b];
}

-(void)setUpInnerImageViewSize
{
	CGRect a = self.innerView.frame;
	a.size.width +=25;
	a.size.height +=20;
	a.origin.y = 10;
	a.origin.x = 10;
	self.frame = a;
	
	CGRect b = self.innerView.frame;
	b.origin.y = 8;	
	b.origin.x = 10;
	
	[self.innerView setFrame:b];
}

-(BOOL)isUserInteractionEnabled
{
	return YES;	
}

-(void)addText:(NSString *)text
{
	self.textValue = text;
	[[self label] performSelectorOnMainThread : @selector(setText:) withObject:text waitUntilDone:YES];
	[self addSubview:[self label]];
	[[self label] sizeToFit];
	[self setUpTextImageSize];
}

-(void)addImage:(UIImage *)image
{
	self.imageValue = image;
	[self addSubview:[self innerImage:image]];
	[[self innerImage:nil] sizeToFit];
	[self setUpInnerImageImageSize];
}

-(void)addImageView:(TiUIView *)view
{
	[view setUserInteractionEnabled:NO];
	self.isView = YES;
	self.prox = view.proxy;
	self.innerView = view;
	
	//this is just a quick workaround, just for now
	
	CGRect a = view.frame;
	a.origin.x = 0;
	a.origin.y = 0;
	[view setFrame:a];
	[self performSelectorOnMainThread:@selector(addSubview:) withObject:view waitUntilDone:YES];
	[self setUpInnerImageViewSize];
}


-(NSString*)getNormalizedPath:(NSString*)source
{
	if ([source hasPrefix:@"file:/"]) {
		NSURL* url = [NSURL URLWithString:source];
		return [url path];
	}
	return source;
}

-(NSString *)resourcesDir:(NSString *)url
{
	url = [[TiHost resourcePath] stringByAppendingPathComponent:[self getNormalizedPath:url]];
	
	return url;
}

-(NSString *)pathOfImage:(NSString *)pos:(NSString *)color
{
	if(!self.folder)
		self.folder = @"";
	NSString *imgName = [[[[[self.folder
							 stringByAppendingString:@"smsview.bundle/"]
							stringByAppendingString:color ]
						   stringByAppendingString:@"Balloon"]
						  stringByAppendingString:pos]
						 stringByAppendingString:@".png" ];
	return [self resourcesDir:imgName];
}

-(void)position:(NSString *)pos:(NSString *)color:(NSString *)selCol
{
	if([pos isEqualToString:@""] || !pos)
		pos = @"Left";
	if([color isEqualToString:@""] || !color)
		color = @"Green";
	if([selCol isEqualToString:@""] || !selCol)
		selCol = @"Blue";
	
	self.thisColor = color;
	self.thisPos = pos;
	self.selectedColor = selCol;
	
	NSString *imgName = [self pathOfImage:pos :color];
	
	if([pos isEqualToString:@"Left"])
	{
		if(self.isText)
		{
			CGRect a = [self label].frame;
			a.origin.x +=5;
			[[self label] setFrame:a];
		}
		if(self.isImage)
		{
			CGRect a = [self innerImage:nil].frame;
			a.origin.x +=5;
			[[self innerImage:nil] setFrame:a];
		}
		if(self.isView)
		{
			CGRect a = self.innerView.frame;
			a.origin.x +=5;
			[self.innerView setFrame:a];
		}
		
		CGRect b = self.frame;
		b.size.width +=10;
		[self setFrame:b];		
		self.image = [[UIImage imageWithContentsOfFile:imgName] stretchableImageWithLeftCapWidth:22 topCapHeight:14];
	}
	else if([pos isEqualToString:@"Right"])
	{
		self.image = [[UIImage imageWithContentsOfFile:imgName] stretchableImageWithLeftCapWidth:20 topCapHeight:14];
		CGRect a = self.frame;
		a.origin.x = (self.superview.frame.size.width-self.frame.size.width)-8;
		a.size.width +=5;
		[self setFrame:a];
	}
	else if([pos isEqualToString:@"Center"])
	{
        //only used by addLabel currently
        self.label.font= [UIFont boldSystemFontOfSize:14];
        self.label.textColor = [UIColor grayColor];
		CGRect a = self.frame;
        a.origin.x = self.superview.frame.size.width/2-a.size.width/2;
		[self setFrame:a];
	}
	else
	{
		NSLog(@"[ERROR] need to know if it's \"Left\" or \"Center\" or \"Right\", stupid!");
	}

}

-(void)resetImage
{
	self.image = [[UIImage imageWithContentsOfFile:[self pathOfImage:self.thisPos:self.thisColor]] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self resetImage];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self resetImage];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self resetImage];		
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSString *imgName = [self pathOfImage:self.thisPos:self.selectedColor];
	self.image = [[UIImage imageWithContentsOfFile:imgName] stretchableImageWithLeftCapWidth:21 topCapHeight:14];

}

@end