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
    HPGrowingTextView *textView;
}

-(id)value;
@end
