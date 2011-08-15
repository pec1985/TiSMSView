//
//  ChatWindow.m
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PEChatWindow.h"



@implementation PEChatWindow

- (void)dealloc
{
	[textArea release];
	[scrollView release];
    [super dealloc];
}

-(id)init
{
	self = [super init];
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

-(PETextArea *)textArea 
{
	if(!textArea){
		textArea = [[PETextArea alloc] initWithFrame:self.view.frame];
		textArea.delegate = self;
	}
	return textArea;
}

-(PEScrollView *)scrollView
{
	if(!scrollView)
	{
		CGFloat h = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame);
		CGRect a = self.view.frame;
		a.size.height = h - 40;
		a.origin.y = 0;
		scrollView = [[PEScrollView alloc] initWithFrame:a];
		scrollView.backgroundColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
		scrollView.delegate = self;
	}
	return scrollView;
}

- (void)loadView
{
	[super loadView];
	[self.view addSubview: [self scrollView]];
	[self.view addSubview: [self textArea]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
-(void)textViewButtonPressed:(NSString *)text
{
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
	[[self textArea] emptyTextView];
	[[self scrollView] reloadContentSize];
}
-(void)scrollViewClicked:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self blur];
}

@end