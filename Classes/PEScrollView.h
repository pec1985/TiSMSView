//
//  ScrollView.h
//  chat
//
//  Created by Pedro Enrique on 8/12/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PELabel.h"

@protocol PEScrollViewDelegate<UIScrollViewDelegate>
@optional

-(void)scrollViewClicked:(NSSet *)touches withEvent:(UIEvent *)event;

@end


@interface PEScrollView : UIScrollView {
	id<PEScrollViewDelegate> delegate;
	UILabel *sentLabel;
	UILabel *recieveLabel;
	PELabel *label;
}

@property(nonatomic, assign) id<PEScrollViewDelegate>  delegate;
@property(nonatomic) CGRect labelsPosition;
@property(nonatomic, retain)NSString *sColor;
@property(nonatomic, retain)NSString *rColor;



-(void)sendMessage:(NSString *)text;;
-(void)recieveMessage:(NSString *)text;;
-(void)reloadContentSize;
-(void)backgroundColor:(UIColor *)col;
-(void)sendColor:(NSString *)col;
-(void)recieveColor:(NSString *)col;
@end
