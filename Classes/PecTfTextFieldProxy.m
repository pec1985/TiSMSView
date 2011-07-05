//
//  PecTfTextFieldProxy.m
//  textfield
//
//  Created by Pedro Enrique on 7/3/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PecTfTextField.h"
#import "PecTfTextFieldProxy.h"
#import "TiUtils.h"

@implementation PecTfTextFieldProxy

-(void)loadView
{
}

-(void)blur:(id)args
{
	PecTfTextField *tf = (PecTfTextField *)[self view];
	if ([self viewAttached])
	{
		[tf performSelectorOnMainThread:@selector(resignTextView) withObject:nil waitUntilDone:NO];
	}
}

-(void)focus:(id)args
{
	
	NSLog(@"Not yet implemented");
	/*
	HPTextViewInternal *tf = (HPTextViewInternal *)[self view];
	if ([self viewAttached])
	{
		[tf becomeFirstResponder];
		//		[tf performSelectorOnMainThread:@selector(becomeFirstResponder) withObject:nil waitUntilDone:NO];
	}

	 */
}

-(void)viewDidAttach
{
	PecTfTextField * ourView = (PecTfTextField *)[self view];
	[[NSNotificationCenter defaultCenter] addObserver:ourView 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:ourView 
											 selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification 
											   object:nil];	
	[super viewDidAttach];
}

-(id)value
{
	PecTfTextField * ourView = (PecTfTextField *)[self view];
	return [ourView value];
}
@end
