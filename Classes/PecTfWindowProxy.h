//
//  PecTfWindowProxy.h
//  textfield
//
//  Created by Pedro Enrique on 8/14/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import "TiWindowProxy.h"
#import "TiProxy.h"
#import "PEChatWindow.h"


@interface PecTfWindowProxy : TiWindowProxy {
	PEChatWindow *win;
	NSString *typeOfWindow;
}

@end
