//
//  ChatWindow.h
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PETextArea.h"
#import "PEScrollView.h"


@interface PEChatWindow : UIViewController<PETextAreaDelegate, PEScrollViewDelegate> {
	PETextArea *textArea;
	PEScrollView *scrollView;
	BOOL testM;
}

-(void)changeHeightOfScrollView;

@end
