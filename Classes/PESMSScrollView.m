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

-(void)dealloc
{
	RELEASE_TO_NIL(label);
	for (int i = 0; i<[views count]; i++) {
		id a = [views objectAtIndex:i];
		RELEASE_TO_NIL(a);
	}
	RELEASE_TO_NIL(views);
	[super dealloc];
}

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
		self.labelsPosition = self.frame;
		self.animated = YES;
	}
    return self;
}

-(NSMutableArray *)views
{
	if(!views)
		views = [[NSMutableArray alloc] init];
	return views;
}
-(PESMSLabel *)label:(NSString *)text:(UIImage *)image
{
	[self performSelectorOnMainThread:@selector(reloadContentSize) withObject:nil waitUntilDone:YES];

	label = [[PESMSLabel alloc] init];
	[self addSubview:label];
	
	if(text)
		[label addText:text];
	if(image)
		[label addImage:image];
	
	CGRect frame = label.frame;
	frame.origin.y += labelsPosition.origin.y;	
	[label setFrame:frame];
	
	CGRect a = self.labelsPosition;
	a.origin.y = frame.origin.y+frame.size.height;
	self.labelsPosition = a;
	[views addObject:label];

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([delegate respondsToSelector:@selector(scrollViewClicked:withEvent:)]) {
		[delegate scrollViewClicked:touches withEvent:event];
	}		
}

-(void)sendColor:(NSString *)col
{
    self.sColor = col;
}
-(void)recieveColor:(NSString *)col
{
    self.rColor = col;
}

-(void)backgroundColor:(UIColor *)col
{
	self.backgroundColor = col;
}

-(void)recieveImage:(UIImage *)image
{
	if(!self.rColor)
		self.rColor = @"Green";
	[[self label:nil:image] position:@"Left":self.sColor];
	RELEASE_TO_NIL(label);
}

-(void)sendImage:(UIImage *)image
{
	if(!self.sColor)
		self.sColor = @"White";
	[[self label:nil:image] position:@"Right":self.sColor];
	RELEASE_TO_NIL(label);
}


-(void)recieveMessage:(NSString *)text;
{
    if(!self.rColor)
        self.rColor = @"Green";
    
	[[self label:text:nil] position:@"Left":self.rColor];
	RELEASE_TO_NIL(label);
}

-(void)sendMessage:(NSString *)text;
{	
    if(!self.sColor)
        self.sColor = @"White";
	
	[[self label:text:nil] position:@"Right":self.sColor];
	RELEASE_TO_NIL(label);
}

-(void)animate:(BOOL)arg
{
	self.animated = arg;
}

@end
