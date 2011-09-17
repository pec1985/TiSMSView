//
//  ScrollView.m
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PESMSScrollView.h"
#import "TiUtils.h"

@implementation PESMSScrollView
@synthesize delegate;
@synthesize labelsPosition;
@synthesize sColor;
@synthesize rColor;
@synthesize animated;
@synthesize selectedColor;
@synthesize folder;
@synthesize allMessages;
@synthesize numberOfMessage;
-(void)dealloc
{
	RELEASE_TO_NIL(allMessages);
	[super dealloc];
}

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
		self.labelsPosition = self.frame;
		self.animated = YES;
		allMessages = [[NSMutableArray alloc] init];
		self.allMessages = allMessages;
		self.numberOfMessage = 0;
	}
    return self;
}

-(PESMSLabel *)label:(NSString *)text:(UIImage *)image:(TiUIView *)view
{
	
	[self performSelectorOnMainThread:@selector(reloadContentSize) withObject:nil waitUntilDone:YES];

	label = [[[PESMSLabel alloc] init] autorelease];
	[label setFolder:self.folder];
	
	[self addSubview:label];
	
	if(text)
		[label addText:text];
	if(image)
		[label addImage:image];
	if(view)
		[label addImageView:view];
	
	CGRect frame = label.frame;
	frame.origin.y += labelsPosition.origin.y;	
	[label setFrame:frame];
	
	CGRect a = self.labelsPosition;
	a.origin.y = frame.origin.y+frame.size.height;
	self.labelsPosition = a;
	[label setIndex_:self.numberOfMessage++];
	[self.allMessages addObject:label];
	return label;
}

-(void)reloadContentSize
{
    if(CGRectIsEmpty(self.labelsPosition))
        self.labelsPosition = self.frame;
    
	CGFloat bottomOfContent = self.labelsPosition.origin.y;//+self.labelsPosition.size.height;
	
	CGSize contentSize1 = CGSizeMake(self.frame.size.width , bottomOfContent);
	
	
	[self setContentSize:contentSize1];
	
	CGRect contentSize2 = CGRectMake(0,0,self.frame.size.width, bottomOfContent);
	
	[self scrollRectToVisible: contentSize2 animated: self.animated];	
}

-(void)sendColor:(NSString *)col
{
    self.sColor = col;
}
-(void)recieveColor:(NSString *)col
{
    self.rColor = col;
}

-(void)selectedColor:(NSString *)col
{
	self.selectedColor = col;
}

-(void)backgroundColor:(UIColor *)col
{
	self.backgroundColor = col;
}

-(void)recieveImage:(UIImage *)image
{
	if(!self.rColor)
		self.rColor = @"White";
	[[self label:nil:image:nil] position:@"Left":self.rColor:self.selectedColor];
}

-(void)sendImage:(UIImage *)image
{
	if(!self.sColor)
		self.sColor = @"Green";
	[[self label:nil:image:nil] position:@"Right":self.sColor:self.selectedColor];
}

-(void)recieveImageView:(TiUIView *)view
{
	if(!self.rColor)
		self.rColor = @"White";
	[[self label:nil:nil:view] position:@"Left":self.rColor:self.selectedColor];
}

-(void)sendImageView:(TiUIView *)view
{
	if(!self.sColor)
		self.sColor = @"Green";
	[[self label:nil:nil:view] position:@"Right":self.sColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)recieveMessage:(NSString *)text;
{
    if(!self.rColor)
        self.rColor = @"White";
    
	[[self label:text:nil:nil] position:@"Left":self.rColor:self.selectedColor];
}

-(void)sendMessage:(NSString *)text;
{	
    if(!self.sColor)
        self.sColor = @"Green";
	
	[[self label:text:nil:nil] position:@"Right":self.sColor:self.selectedColor];
}

-(void)animate:(BOOL)arg
{
	self.animated = arg;
}

-(void)empty
{
	ENSURE_UI_THREAD_0_ARGS
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	self.labelsPosition = self.frame;
	[self reloadContentSize];
	[self.allMessages removeAllObjects];
	self.numberOfMessage = 0;
	[self setNeedsDisplay];
}

@end
