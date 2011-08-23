//
//  TextArea.m
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PETextArea.h"

// titanium project:
#import "TiHost.h"

@implementation PETextArea
@synthesize delegate, text;

-(void)dealloc
{
	[textView release];
	textView = nil;
	[entryImageView release];
	entryImageView = nil;
	[imageView release];
	imagesPath = nil;
	
	[super dealloc];
}

-(id)init
{
	self = [super init];
	return self;
}

// titanium project:
-(NSString*)getNormalizedPath:(NSString*)source
{
	if ([source hasPrefix:@"file:/"]) {
		NSURL* url = [NSURL URLWithString:source];
		return [url path];
	}
	return source;
}

-(UIImage *)resourcesImage:(NSString *)url
{
	// normal project:
	// images = [UIImage imageNamed:url];
	
	// titanium project:
	images = [[[UIImage alloc] initWithContentsOfFile: [[TiHost resourcePath] stringByAppendingPathComponent:[self getNormalizedPath:url]]]autorelease ];
	
	return images;
}


- (HPGrowingTextView *)textView {
	if(textView==nil)
	{
		textView = [[HPGrowingTextView alloc] init];
		textView.minNumberOfLines = 1;
		textView.maxNumberOfLines = 4;
		textView.returnKeyType = UIReturnKeyDefault;
		textView.font = [UIFont boldSystemFontOfSize:15.0f];
		textView.delegate = self;
		[textView sizeToFit];
	}
	return textView;
}

-(UIButton *)doneBtn
{
	if(!doneBtn)
	{
		doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		
		[doneBtn setTitle:@"Send" forState:UIControlStateNormal];
		
		[doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
		doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
		doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		[doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[doneBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
		
		UIImage *sendBtnBackground = [[self resourcesImage:@"textarea.bundle/MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
		UIImage *selectedSendBtnBackground = [[self resourcesImage:@"textarea.bundle/MessageEntrySendButton.png"]stretchableImageWithLeftCapWidth:13 topCapHeight:0];
		
		[doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
		[doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
		
	}
	return doneBtn;
}

-(UIImageView *)entryImageView
{
	if(!entryImageView)
	{
		entryImageView = [[UIImageView alloc] init];
		entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		
		UIImage *rawEntryBackground = [self resourcesImage:@"textarea.bundle/MessageEntryInputField.png"];
		UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
		
		[entryImageView setImage:entryBackground];
	}
	return entryImageView;
}

-(void)buttonTitle:(NSString *)title
{
	[[self doneBtn] setTitle:title forState:UIControlStateNormal];
}

-(UIImageView *)imageView
{
	if(!imageView)
	{
		imageView = [[UIImageView alloc] init];
		UIImage *rawBackground = [self resourcesImage:@"textarea.bundle/MessageEntryBackground.png"];
		UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
		[imageView setImage:background];
		imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	}
	return imageView;
}

-(void)resize
{
	CGFloat w = CGRectGetWidth(self.superview.frame);
	CGFloat h = CGRectGetHeight(self.superview.frame);
	[[self textView]		setFrame: CGRectMake(6, 3, w - 80, 40)];
	[[self doneBtn ]		setFrame: CGRectMake(w - 69, 8, 63, 27)];
	[[self imageView]		setFrame: CGRectMake(0, 0, w, h)];
	[[self entryImageView]	setFrame: CGRectMake(5, 0, w-72, 40)];
	[self					setFrame: CGRectMake(0, h - 40, w, 40)];
	
}

- (void)layoutSubviews
{
	if(!firstTime)
	{
		firstTime = YES;
		[self resize];
		// view hierachy
		[self addSubview:[self imageView]];
		[self addSubview:[self textView]];
		[self addSubview:[self entryImageView]];
		[self addSubview:[self doneBtn]];	
	}
}

-(void)buttonPressed
{
	if ([delegate respondsToSelector:@selector(textViewButtonPressed:)]) {
		[delegate textViewButtonPressed:[self textView].text];
	}	
	
}

-(void)becomeTextView
{
	if ([delegate respondsToSelector:@selector(textViewFocus)]) {
		[delegate textViewFocus];
	}	
	[[self textView] becomeFirstResponder];
}

-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
	[self becomeTextView];
}


-(void)resignTextView
{
	if ([delegate respondsToSelector:@selector(textViewBlur)]) {
		[delegate textViewBlur];
	}	
	[[self textView ] resignFirstResponder];
}

-(void)emptyTextView
{
	[[self textView] setText:@""];
}

-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
	self.text = [self textView].text;
	if([delegate respondsToSelector:@selector(textViewTextChange:)])
	{
		[delegate textViewTextChange:self.text];
	}
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
	float diff = (self.frame.size.height - height);
	
	CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.frame = r;
	if ([delegate respondsToSelector:@selector(heightOfTextViewDidChange:)]) {
		[delegate heightOfTextViewDidChange:diff];
	}	
}



@end
