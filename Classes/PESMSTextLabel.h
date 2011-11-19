//
//  PESMSTextLabel.h
//  textfield
//
//  Created by Pedro Enrique on 10/26/11.
//  Copyright 2011 Appcelerator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PESMSTextLabel : UILabel

@property(nonatomic)int index_;

-(void)addText:(NSString *)text;
-(void)resize:(CGRect)frame;
@end
