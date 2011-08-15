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
@synthesize value;

-(void)dealloc
{
	RELEASE_TO_NIL(textArea);
	RELEASE_TO_NIL(scrollView);

	[super dealloc];
}

-(PETextArea *)textArea 
{
	if(!textArea){
		textArea = [[PETextArea alloc] initWithFrame:self.frame];
		textArea.delegate = self;
	}
	return textArea;
}

-(PEScrollView *)scrollView
{
	if(!scrollView)
	{
		CGFloat h = CGRectGetHeight(self.frame);// - CGRectGetHeight(self.navigationController.navigationBar.frame);
		CGRect a = self.frame;
		a.size.height = h - 40;
		a.origin.y = 0;
		scrollView = [[PEScrollView alloc] initWithFrame:a];
		scrollView.backgroundColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
		scrollView.delegate = self;
	}
	return scrollView;
}


//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect containerFrame = [self textArea].frame;
	containerFrame.origin.y -= kbSizeH;
	CGRect scrollViewFrame = [self scrollView].frame;	
	scrollViewFrame.size.height -=kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	[self scrollView].frame = scrollViewFrame;
	[self textArea].frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
	[[self scrollView] reloadContentSize];
}

-(void)changeHeightOfScrollView
{
	NSLog(@"changeHeightOfScrollView");
}

-(void) keyboardWillHide:(NSNotification *)note{
    // get keyboard size and location
	CGRect keyboardBounds;
	
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect containerFrame = [self textArea].frame;
	containerFrame.origin.y += kbSizeH;
	CGRect scrollViewFrame = [self scrollView].frame;	
	scrollViewFrame.size.height +=kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
	
	// set views with new info
	[[self scrollView]setFrame: scrollViewFrame];
	[[self textArea] setFrame: containerFrame];
	
	// commit animations
	[UIView commitAnimations];
}
-(void)heightOfTextViewDidChange:(float)height
{
	CGRect scrollViewFrame = [self scrollView].frame;	
	scrollViewFrame.size.height +=height;
	[[self scrollView]setFrame: scrollViewFrame];
	[[self scrollView] reloadContentSize];
}
-(void)blur
{
	[[self textArea] resignTextView];
}
-(void)focus
{
	[[self textArea] becomeTextView];
}

-(void)sendMessage:(NSString *)msg
{
	if([msg isEqualToString:@""])
		return;
	[[self scrollView] performSelectorOnMainThread:@selector(sendMessage:) withObject:msg waitUntilDone:YES];
	[[self scrollView] performSelectorOnMainThread:@selector(reloadContentSize) withObject:nil waitUntilDone:YES];
}
-(void)recieveMessage:(NSString *)msg
{
	if([msg isEqualToString:@""])
		return;
	[[self scrollView] performSelectorOnMainThread:@selector(recieveMessage:) withObject:msg waitUntilDone:YES];
	[[self scrollView] performSelectorOnMainThread:@selector(reloadContentSize) withObject:nil waitUntilDone:YES];
}

-(void)textViewButtonPressed:(NSString *)text
{
	NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	[tiEvent setObject:text forKey:@"value"];
	[self.proxy fireEvent:@"buttonClicked" withObject:tiEvent];
/*
	if(!testM)
	{
		[[self scrollView] sendMessage:text];
		testM = YES;
	}	
	else
	{
		[[self scrollView] recieveMessage:text];
		testM = NO;
	}
*/
	[[self textArea] emptyTextView];
	[[self scrollView] reloadContentSize];
}
-(void)textViewTextChange:(NSString *)text
{
	NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];
	[tiEvent setObject:text forKey:@"value"];
	[self.proxy fireEvent:@"change" withObject:tiEvent];

	self.value = text;
}
-(void)scrollViewClicked:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSMutableDictionary *tiEvent = [NSMutableDictionary dictionary];

	[self.proxy fireEvent:@"click" withObject:tiEvent];

	[self blur];
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	if(!testM)
	{
		testM = YES;
		self.frame = self.superview.frame;
		[self addSubview: [self scrollView]];
		[self addSubview: [self textArea]];

	}
	
}

/*

 #pragma mark JavaScript setters and getters

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
*/
@end
