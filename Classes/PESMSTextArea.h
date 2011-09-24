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
-(void)textViewSendButtonPressed:(NSString *)text;
-(void)textViewCamButtonPressed:(NSString *)text;
-(void)textViewFocus;
-(void)textViewBlur;
-(void)textViewTextChange:(NSString *)text;;

@end

@interface PESMSTextArea : UIView<HPGrowingTextViewDelegate> {
	NSObject <PESMSTextAreaDelegate>* delegate;
    HPGrowingTextView *textView;
	UIButton *doneBtn;
	UIButton *camButton;
	UIImageView *entryImageView;
	UIImageView *imageView;
	UIImage *images;
	NSString *imagesPath;
}

@property(assign) NSObject<PESMSTextAreaDelegate> *delegate;
@property(nonatomic, retain)NSString *text;
@property(nonatomic, retain)NSString *folder;
@property(nonatomic)BOOL hasCam;
@property(nonatomic)BOOL firstTime;
@property(nonatomic)int maxLines;
@property(nonatomic)int minLines;

-(void)resize;
-(void)resignTextView;
-(void)emptyTextView;
-(void)becomeTextView;
-(void)buttonTitle:(NSString *)title;
-(void)setCamera:(BOOL)val;
-(void)disableDoneButon:(BOOL)arg;
-(void)disableCamButon:(BOOL)arg;
- (HPGrowingTextView *)textView;

@end
