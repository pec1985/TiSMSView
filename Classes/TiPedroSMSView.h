//
//  PecTfTextField.h
//  textfield
//
//  Created by Pedro Enrique on 7/3/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "TiUIView.h"
#import "PESMSTextArea.h"
#import "PESMSScrollView.h"


@interface TiPedroSMSView : TiUIView<PESMSTextAreaDelegate, PESMSScrollViewDelegate> {
	PESMSTextArea *textArea;
	PESMSScrollView *scrollView;
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
@property(nonatomic)BOOL hasCam;

-(void)sendImage:(UIImage *)image;
-(void)recieveImage:(UIImage *)image;
-(void)sendMessage:(NSString *)msg;
-(void)recieveMessage:(NSString *)msg;
-(void)_blur;
-(void)_focus;
@end
