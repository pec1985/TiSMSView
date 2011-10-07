//
//  ScrollView.h
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PESMSLabel.h"
#import "TiUIView.h"


@interface PESMSScrollView : UIScrollView {
	UILabel *sentLabel;
	UILabel *recieveLabel;
	PESMSLabel *label;
	NSMutableArray *allMessages;
	NSMutableDictionary *tempDict;
}

@property(nonatomic) CGRect labelsPosition;
@property(nonatomic, retain)NSString *sColor;
@property(nonatomic, retain)NSString *rColor;
@property(nonatomic, retain)NSString *selectedColor;
@property(nonatomic, retain)NSString *folder;
@property(nonatomic, retain)NSMutableArray *allMessages;
@property(nonatomic, retain)NSMutableDictionary *tempDict;
@property(nonatomic)BOOL animated;
@property(nonatomic)int numberOfMessage;

-(void)sendMessage:(NSString *)text;
-(void)recieveMessage:(NSString *)text;
-(void)addLabel:(NSString *)msg;
-(void)sendImageView:(TiUIView *)view;
-(void)recieveImageView:(TiUIView *)view;
-(void)sendImage:(UIImage *)image;
-(void)recieveImage:(UIImage *)image;
-(void)reloadContentSize;
-(void)backgroundColor:(UIColor *)col;
-(void)sendColor:(NSString *)col;
-(void)recieveColor:(NSString *)col;
-(void)animate:(BOOL)arg;
-(void)selectedColor:(NSString *)col;
-(void)empty;

@end
