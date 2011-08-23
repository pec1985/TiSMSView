//
//  PecTfTextField.h
//  textfield
//
//  Created by Pedro Enrique on 7/3/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "TiUIView.h"
#import "PETextArea.h"
#import "PEScrollView.h"


@interface PecTfTextField : TiUIView<PETextAreaDelegate, PEScrollViewDelegate> {
	PETextArea *textArea;
	PEScrollView *scrollView;
	BOOL deallocOnce;
	NSString *value;
}

@property(nonatomic, retain)NSString *value;
@property(nonatomic)BOOL firstTime;
@property(nonatomic)UIReturnKeyType returnType;
@property(nonatomic, retain)WebFont* font;
@property(nonatomic, retain)TiColor *textColor;
@property(nonatomic)UITextAlignment textAlignment;
@property(nonatomic)BOOL autocorrect;
@property(nonatomic)BOOL beditable;

-(void)sendMessage:(NSString *)msg;
-(void)recieveMessage:(NSString *)msg;

@end
/*
 //
 //  PecTfTextField.h
 //  textfield
 //
 //  Created by Pedro Enrique on 7/3/11.
 //  Copyright 2011 Appcelerator. All rights reserved.
 //
 
 #import "TiUIView.h"
 #import "HPGrowingTextView.h"
 
 @interface PecTfTextField : TiUIView<HPGrowingTextViewDelegate> {
 
 UIView *containerView;
 HPGrowingTextView *textView;
 CGRect mainFrame;
 UIImageView *entryImageView;
 UIImageView *imageView;
 UIButton *doneBtn;
 float bottomMargin;
 }
 
 @property (nonatomic) CGRect mainFrame;
 @property (nonatomic) float bottomMargin;
 
 -(id)value;
 -(void)resignTextView;
 -(void)becomeTextView;
 
 @end
 */