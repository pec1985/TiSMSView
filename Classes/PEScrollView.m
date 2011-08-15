//
//  ScrollView.m
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "PEScrollView.h"

@implementation PEScrollView
@synthesize delegate, labelsPosition;

-(void)dealloc
{
	[delegate release];
	[sentLabel release];
	[label release];
	[super dealloc];
	
}

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
		self.labelsPosition = self.frame;
	}
    return self;
}

-(PELabel *)label:(NSString *)text
{
	label = [[PELabel alloc] init];
	[self addSubview:label];
	
	[label addText:text];
	
	CGRect frame = label.frame;
	frame.origin.y += labelsPosition.origin.y;	
	[label setFrame:frame];
	
	CGRect a = self.labelsPosition;
	a.origin.y = frame.origin.y+frame.size.height;
	self.labelsPosition = a;

	return label;
}

-(void)reloadContentSize
{
	CGFloat bottomOfContent = self.labelsPosition.origin.y;//+self.labelsPosition.size.height;
	
	CGSize contentSize1 = CGSizeMake(self.frame.size.width , bottomOfContent);
	
	
	[self setContentSize:contentSize1];
	
	CGRect contentSize2 = CGRectMake(0,0,self.frame.size.width, bottomOfContent);
	
	[self scrollRectToVisible: contentSize2 animated: YES];	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([delegate respondsToSelector:@selector(scrollViewClicked:withEvent:)]) {
		[delegate scrollViewClicked:touches withEvent:event];
	}		
}

-(void)recieveMessage:(NSString *)text;
{
	/*
	 Colors:
			Blue
			Purple
			Green
			Gray
			White
	*/
	[[self label:text] position:@"Right":@"Green"];
//	[self reloadContentSize];

}

-(void)sendMessage:(NSString *)text;
{
	/*
	 Colors:
			Blue
			Purple
			Green
			Gray
			White
	*/
	[[self label:text] position:@"Left":@"White"];
//	[self reloadContentSize];
}

@end
