//
//  TextArea.h
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@class HPGrowingTextView;

@protocol PESMSTextAreaDelegate
@optional

-(void)heightOfTextViewDidChange:(float)height;
-(void)textViewButtonPressed:(NSString *)text;
-(void)textViewFocus;
-(void)textViewBlur;
-(void)textViewTextChange:(NSString *)text;;

@end

@interface PESMSTextArea : UIView<HPGrowingTextViewDelegate> {
	NSObject <PESMSTextAreaDelegate>* delegate;
    HPGrowingTextView *textView;
	UIButton *doneBtn;
	UIImageView *entryImageView;
	UIImageView *imageView;
	UIImage *images;
	NSString *imagesPath;
	BOOL firstTime;
}

@property(assign) NSObject<PESMSTextAreaDelegate> *delegate;
@property(nonatomic, retain)NSString *text;
-(void)resize;
-(void)resignTextView;
-(void)emptyTextView;
-(void)becomeTextView;
-(void)buttonTitle:(NSString *)title;
- (HPGrowingTextView *)textView;

@end
