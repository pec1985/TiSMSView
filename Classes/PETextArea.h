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

@protocol PETextAreaDelegate
@optional

-(void)heightOfTextViewDidChange:(float)height;
-(void)textViewButtonPressed:(NSString *)text;
-(void)textViewFocus;
-(void)textViewBlur;
-(void)textViewTextChange:(NSString *)text;;

@end

@interface PETextArea : UIView<HPGrowingTextViewDelegate> {
	NSObject <PETextAreaDelegate>* delegate;
    HPGrowingTextView *textView;
	UIButton *doneBtn;
	UIImageView *entryImageView;
	UIImageView *imageView;
	UIImage *images;
	UIView *containerView;
	NSString *imagesPath;
	BOOL firstTime;
}

@property(assign) NSObject<PETextAreaDelegate> *delegate;
@property(nonatomic, retain)NSString *text;
-(void)resignTextView;
-(void)emptyTextView;
-(void)becomeTextView;
@end
