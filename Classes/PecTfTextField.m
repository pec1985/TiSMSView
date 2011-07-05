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


@implementation PecTfTextField

-(void)dealloc
{
	if(textView != nil)
		textView = nil;
	RELEASE_TO_NIL(textView);
	[super dealloc];
}

- (HPGrowingTextView *)textView {
	
	if(textView==nil)
	{
		
		[self setBackgroundColor:[UIColor blueColor]];
	
		textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
		textView.minNumberOfLines = 1;
		textView.maxNumberOfLines = 4;
		textView.returnKeyType = UIReturnKeyGo; //just as an example
		textView.font = [UIFont boldSystemFontOfSize:15.0f];
		textView.delegate = self;
		//textView.animateHeightChange = NO; //turns off animation
		[textView sizeToFit];

		
		[self addSubview:textView];
		
	}
	return textView;
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

//===== still not working ======

-(void)setEnableReturnKey_:(id)value
{
	[[self textView] setEnablesReturnKeyAutomatically:[TiUtils boolValue:value]];
}

-(void)setKeyboardType_:(id)value
{
	[[self textView] setKeyboardType:[TiUtils intValue:value]];
}

-(void)setAutocorrect_:(id)value
{
	[[self textView] setAutocorrectionType:[TiUtils boolValue:value] ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo];
}

// =============================


-(id)value
{
	return [[self textView] text];
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	if(textView!=nil)
	{
		
		[TiUtils setView:textView positionRect:
			CGRectMake(
						0,
						CGRectGetHeight([self frame])-CGRectGetHeight([textView frame]),
						CGRectGetWidth([self frame]),
						CGRectGetHeight([textView frame])
			)];
	}
}


-(void)resignTextView
{
	[textView resignFirstResponder];
}






//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect textViewFrame = textView.frame;
	textViewFrame.origin.y -= kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	textView.frame = textViewFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    // get keyboard size and location
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect textViewFrame = textView.frame;
	textViewFrame.origin.y += kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	textView.frame = textViewFrame;
	
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
	float diff = (textView.frame.size.height - height);
	
	CGRect r = textView.frame;
	r.origin.y += diff;
	textView.frame = r;
}




@end
