//
//  Label.h
//  chat
//
//  Created by Pedro Enrique on 8/13/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PESMSLabel : UIImageView {
    UIImage *backgroundImage;
	UILabel *label;
}

@property(nonatomic, retain)NSString *sColor;
@property(nonatomic, retain)NSString *rColor;


-(void)addText:(NSString *)text;
-(void)position:(NSString *)pos:(NSString *)color;



@end
