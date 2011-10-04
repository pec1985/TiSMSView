//
//  Label.h
//  chat
//
//  Created by Pedro Enrique on 8/13/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIView.h"
#import "TiProxy.h"

@interface PESMSLabel : UIImageView<UIGestureRecognizerDelegate>
{
	UILabel *label;
	UIImageView *innerImage;
	UIView *innerView;
	UILongPressGestureRecognizer *hold;
}

@property(nonatomic, retain)NSString *sColor;
@property(nonatomic, retain)NSString *rColor;
@property(nonatomic, retain)NSString *thisPos;
@property(nonatomic, retain)NSString *thisColor;
@property(nonatomic, retain)NSString *selectedColor;
@property(nonatomic, retain)NSString *textValue;
@property(nonatomic, retain)UIView *innerView;
@property(nonatomic, retain)NSString *folder;
@property(nonatomic, retain)TiProxy *prox;
@property(nonatomic, retain)UIImage *imageValue;
@property(nonatomic)BOOL isImage;
@property(nonatomic)BOOL isText;
@property(nonatomic)BOOL isView;
@property(nonatomic)int index_;
@property(nonatomic)UIDeviceOrientation orient;

-(void)addImage:(UIImage *)image;
-(void)addText:(NSString *)text;
-(void)position:(NSString *)pos:(NSString *)color:(NSString *)selCol;
-(void)addImageView:(TiUIView *)view;

@end
