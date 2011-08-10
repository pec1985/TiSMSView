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
}

@property (nonatomic) CGRect mainFrame;

-(id)value;
@end
