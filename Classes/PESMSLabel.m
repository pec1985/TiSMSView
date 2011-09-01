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
@synthesize delegate;
@synthesize innerView;
@synthesize folder;

-(void)dealloc
{
	if(self.isText)
		RELEASE_TO_NIL(label);
	if(self.isImage)
		RELEASE_TO_NIL(innerImage);
	if(self.isView)
		RELEASE_TO_NIL(innerView);
	[super dealloc];
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
	if(x.size.width > self.superview.frame.size.width-100)
	{
		x.size.width = self.superview.frame.size.width-100;
		[[self label] setFrame:x];
		[[self label] sizeToFit];
		
	}
	CGRect a = [self label].frame;
	a.size.width +=25;
	a.size.height +=10;
	a.origin.y = 10;
	a.origin.x = 10;
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
	[[self label] performSelectorOnMainThread : @selector(setText:) withObject:text waitUntilDone:YES];
	[self addSubview:[self label]];
	[[self label] sizeToFit];
	[self setUpTextImageSize];
}

-(void)addImage:(UIImage *)image
{
	[self addSubview:[self innerImage:image]];
	[[self innerImage:nil] sizeToFit];
	[self setUpInnerImageImageSize];
}

-(void)addImageView:(UIView *)view
{
	self.isView = YES;
	self.innerView = [[UIView alloc] init];
	self.innerView = view;
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
		a.origin.x = (self.superview.frame.size.width-self.frame.size.width)-20;
		a.size.width +=10;
		[self setFrame:a];
	}
	else
	{
		NSLog(@"[ERROR] need to know if it's \"Left\" or \"Right\", stupid!");
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
	id whatever;
	if ([delegate respondsToSelector:@selector(PESMSLabelClicked:withEvent::::)])
	{
		if(self.isText)
		{
			whatever = [[self label] text];
			[delegate PESMSLabelClicked:touches withEvent:event:nil:whatever:nil];
		}
		if(self.isImage)
		{
			whatever = [[self innerImage:nil] image];
			[delegate PESMSLabelClicked:touches withEvent:event:whatever:nil:nil];
		}
		if(self.isView)
		{
			whatever = (UIView *)self.innerView;
			[delegate PESMSLabelClicked:touches withEvent:event:nil:nil:whatever];
		}
	}		
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSString *imgName = [self pathOfImage:self.thisPos:self.selectedColor];
	self.image = [[UIImage imageWithContentsOfFile:imgName] stretchableImageWithLeftCapWidth:21 topCapHeight:14];

}

@end