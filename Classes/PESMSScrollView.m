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
@synthesize tempDict;

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
		tempDict = [[NSMutableDictionary alloc] init];
		self.tempDict = tempDict;
		allMessages = [[NSMutableArray alloc] init];
		self.allMessages = allMessages;
		self.numberOfMessage = 0;
	}
    return self;
}

-(PESMSLabel *)label:(NSString *)text:(UIImage *)image:(TiUIView *)view:(NSString *)pos
{

	[self performSelectorOnMainThread:@selector(reloadContentSize) withObject:nil waitUntilDone:YES];

	label = [[PESMSLabel alloc] init];
	[label setFolder:self.folder];
	
	[self.tempDict removeAllObjects];
	
	[self addSubview:label];
	
	if(text)
	{
		[label addText:text];
		[self.tempDict setObject:text forKey:pos];
	}
	if(image)
	{
		[label addImage:image];
		TiBlob *blob = [[[TiBlob alloc] initWithImage:image] autorelease];
		[self.tempDict setObject:blob forKey:pos];
	}
	if(view)
	{
		[label addImageView:view];
		[self.tempDict setObject:view.proxy forKey:pos];
	}
	CGRect frame = label.frame;
	frame.origin.y += labelsPosition.origin.y;	
	[label setFrame:frame];
	
	CGRect a = self.labelsPosition;
	a.origin.y = frame.origin.y+frame.size.height;
	self.labelsPosition = a;
    
	[label setIndex_:self.numberOfMessage];

	[self.tempDict setObject:[NSString stringWithFormat:@"%i",self.numberOfMessage] forKey:@"index"];
	
	self.numberOfMessage++;
	
	[self.allMessages addObject:[NSDictionary dictionaryWithDictionary:self.tempDict]];
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
	[[self label:nil:image:nil:@"recieve"] position:@"Left":self.rColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)sendImage:(UIImage *)image
{
	if(!self.sColor)
		self.sColor = @"Green";
	[[self label:nil:image:nil:@"send"] position:@"Right":self.sColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)recieveImageView:(TiUIView *)view
{
	if(!self.rColor)
		self.rColor = @"White";
	[[self label:nil:nil:view:@"recieve"] position:@"Left":self.rColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)sendImageView:(TiUIView *)view
{
	if(!self.sColor)
		self.sColor = @"Green";
	[[self label:nil:nil:view:@"send"] position:@"Right":self.sColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)recieveMessage:(NSString *)text;
{
    if(!self.rColor)
        self.rColor = @"White";
    
	[[self label:text:nil:nil:@"recieve"] position:@"Left":self.rColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)sendMessage:(NSString *)text;
{	
    if(!self.sColor)
        self.sColor = @"Green";
	
	[[self label:text:nil:nil:@"send"] position:@"Right":self.sColor:self.selectedColor];
	RELEASE_TO_NIL(label);
}

-(void)addLabel:(NSString *)text;
{	
    if(!self.sColor)
        self.sColor = @"Green";
	
	[[self label:text:nil:nil:@"send"] position:@"Center":self.sColor:self.selectedColor];
	RELEASE_TO_NIL(label);
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
	[self.allMessages removeAllObjects];
	self.numberOfMessage = 0;
	[self reloadContentSize];
	[self setNeedsDisplay];
}

@end
