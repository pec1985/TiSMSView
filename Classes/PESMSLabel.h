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

@protocol PESMSLabelDelegate
@optional

-(void)PESMSLabelClicked:(NSSet *)touches withEvent:(UIEvent *)event:(UIImage *)image:(NSString *)text:(TiProxy *)view;

@end

@interface PESMSLabel : UIImageView<UIGestureRecognizerDelegate>
{
	NSObject <PESMSLabelDelegate> *delegate;
	UILabel *label;
	UIImageView *innerImage;
	UIView *innerView;
}

@property(nonatomic, retain)NSString *sColor;
@property(nonatomic, retain)NSString *rColor;
@property(nonatomic, retain)NSString *thisPos;
@property(nonatomic, retain)NSString *thisColor;
@property(nonatomic, retain)NSString *selectedColor;
@property(nonatomic, retain)UIView *innerView;
@property(nonatomic, retain)NSString *folder;
@property(nonatomic, retain)TiProxy *prox;
@property(nonatomic)BOOL isImage;
@property(nonatomic)BOOL isText;
@property(nonatomic)BOOL isView;
@property(assign) NSObject <PESMSLabelDelegate> *delegate;


-(void)addImage:(UIImage *)image;
-(void)addText:(NSString *)text;
-(void)position:(NSString *)pos:(NSString *)color:(NSString *)selCol;
-(void)addImageView:(TiUIView *)view;

@end
