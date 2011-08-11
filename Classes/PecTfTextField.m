//
//  PecTfTextField.m
//  textfield
//
//  Created by Pedro Enrique on 7/3/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PecTfTextField.h"
#import "TiBase.h"
#import "TiUtils.h"
#import "TiHost.h"


@implementation PecTfTextField
@synthesize mainFrame;

-(void)dealloc
{
	RELEASE_TO_NIL(containerView);
	RELEASE_TO_NIL(textView);
	RELEASE_TO_NIL(entryImageView);
	RELEASE_TO_NIL(imageView);
	RELEASE_TO_NIL(doneBtn);

	[super dealloc];
}

-(NSString*)getNormalizedPath:(NSString*)source
{
	// NOTE: File paths may contain URL prefix as of release 1.7 of the SDK
	if ([source hasPrefix:@"file:/"]) {
		NSURL* url = [NSURL URLWithString:source];
		return [url path];
	}
	
	// NOTE: Here is where you can perform any other processing needed to
	// convert the source path. For example, if you need to handle
	// tilde, then add the call to stringByExpandingTildeInPath
	
	return source;
}

-(UIImage *)resourcesImage:(NSString *)url
{
	UIImage *image = [[UIImage alloc] initWithContentsOfFile: [[TiHost resourcePath] stringByAppendingPathComponent:[self getNormalizedPath:url]]];
	return image;
}

- (HPGrowingTextView *)textView {
	if(textView==nil)
	{
		textView = [[HPGrowingTextView alloc] init];
		textView.minNumberOfLines = 1;
		textView.maxNumberOfLines = 4;
		textView.returnKeyType = UIReturnKeyGo; //just as an example
		textView.font = [UIFont boldSystemFontOfSize:15.0f];
		textView.delegate = self;
		[textView sizeToFit];
	}
	return textView;
}

-(UIButton *)doneBtn
{
	if(!doneBtn)
		doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	return doneBtn;
}
-(UIImageView *)entryImageView
{
	if(!entryImageView)
		entryImageView = [[UIImageView alloc] init];
	return entryImageView;
}

-(UIImageView *)imageView
{
	if(!imageView)
		imageView = [[UIImageView alloc] init];
	return imageView;
}



-(UIView *)containerView
{
	if(!containerView)
	{
		containerView = [[UIView alloc] init];
		
		containerView.backgroundColor = [UIColor lightGrayColor];
		
		UIImage *rawEntryBackground = [self resourcesImage:@"textarea.bundle/MessageEntryInputField.png"];

		UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
		[[self entryImageView] setImage:entryBackground];
		entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		
		UIImage *rawBackground = [self resourcesImage:@"textarea.bundle/MessageEntryBackground.png"];
		
		UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
		[[self imageView] setImage:background];
		imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		
		
		UIImage *sendBtnBackground = [[self resourcesImage:@"textarea.bundle/MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
		UIImage *selectedSendBtnBackground = [[self resourcesImage:@"textarea.bundle/MessageEntrySendButton.png"]stretchableImageWithLeftCapWidth:13 topCapHeight:0];
		
		[self doneBtn].autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		
		[[self doneBtn] setTitle:@"Done" forState:UIControlStateNormal];
		
		[[self doneBtn] setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
		[self doneBtn].titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
		[self doneBtn].titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		
		[[self doneBtn] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[[self doneBtn] addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
		[[self doneBtn] setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
		[[self doneBtn] setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
		
		
		// view hierachy
		[containerView addSubview:[self imageView]];
		[containerView addSubview:[self textView]];
		[containerView addSubview:[self entryImageView]];
		[containerView addSubview:[self doneBtn]];	
		
		[self addSubview:containerView];
	}
	return containerView;
}



-(void)setValue_:(id)value
{
	[[self textView] setText:[TiUtils stringValue:value]];
}


-(void)setColor_:(id)color
{
	UIColor * newColor = [[TiUtils colorValue:color] _color];
	[(id)[self textView] setTextColor:(newColor != nil)?newColor:[UIColor darkTextColor]];
}


-(void)setTextAlign_:(id)alignment
{
	[(id)[self textView] setTextAlignment:[TiUtils textAlignmentValue:alignment]];
}

-(void)setReturnKeyType_:(id)value
{
	[[self textView] setReturnKeyType:[TiUtils intValue:value]];
}

-(void)setEnableReturnKey_:(id)value
{
	[(id)[self textView] setEnablesReturnKeyAutomatically:[TiUtils boolValue:value]];
}

-(void)setKeyboardType_:(id)value
{
	[(id)[self textView] setKeyboardType:[TiUtils intValue:value]];
}

-(void)setAutocorrect_:(id)value
{
	[(id)[self textView] setAutocorrectionType:[TiUtils boolValue:value] ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo];
}

-(void)setButtonTitle_:(id)value
{
	ENSURE_SINGLE_ARG(value, NSString);
	
	[[self doneBtn] setTitle:[TiUtils stringValue:value] forState: UIControlStateNormal];
}

-(id)value
{
	return [[self textView] text];
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	if(CGRectIsEmpty(self.mainFrame)){
		self.mainFrame = bounds;//[[UIScreen mainScreen] applicationFrame];
	}
	
	CGFloat w = CGRectGetWidth(self.mainFrame);
	CGFloat h = CGRectGetHeight(self.mainFrame);
	
	[[self containerView]	setFrame: CGRectMake(0, 0, w, 40)];
	[[self textView]		setFrame: CGRectMake(6, 3, w - 80, 40)];
	[[self doneBtn ]		setFrame: CGRectMake(w - 69, 8, 63, 27)];
	[[self imageView]		setFrame: CGRectMake(0, 0, w, h)];
	[[self entryImageView]	setFrame: CGRectMake(5, 0, w-72, 40)];
	[self					setFrame: CGRectMake(0, h - 40, w, 40)];
	
}


-(void)resignTextView
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];

	[self.proxy fireEvent:@"blur" withObject:event];
	
	[(id)[self textView] resignFirstResponder];
}

-(void)becomeTextView
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	
	[self.proxy fireEvent:@"focus" withObject:event];
	
	[(id)[self textView] becomeFirstResponder];
}

-(void)buttonClicked
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	[self.proxy fireEvent:@"buttonClicked" withObject:event];
	
}
//Code from Brett Schumann
-(void)keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	// get a rect for the textView frame
	CGRect containerFrame = self.frame;
	containerFrame.origin.y -= kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25f];
	
	// set views with new info
	[self setFrame: containerFrame];
	
	[UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)note{
    // get keyboard size and location
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect containerFrame = self.frame;
	containerFrame.origin.y += kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25f];
	
	// set views with new info
	[self setFrame: containerFrame];

	// commit animations
	[UIView commitAnimations];

}

-(void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	[event setObject:  [NSString stringWithFormat:@"%f",height] forKey:@"height"];
	[self.proxy fireEvent:@"heightChanged" withObject:event];

}
-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	[self.proxy fireEvent:@"change" withObject:event];
}
-(void)growingTextViewDidChangeSelection:(HPGrowingTextView *)growingTextView
{
	
}

-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	[self.proxy fireEvent:@"keyboardUp" withObject:event];
	
}
-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setObject:[[self textView] text] forKey:@"value"];
	[self.proxy fireEvent:@"keyboardDown" withObject:event];

}



- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
	float diff = ([self containerView].frame.size.height - height);
	
	CGRect r = [self containerView].frame;
    r.size.height -= diff;
    r.origin.y += diff;
	[self containerView ].frame = r;
}




@end
