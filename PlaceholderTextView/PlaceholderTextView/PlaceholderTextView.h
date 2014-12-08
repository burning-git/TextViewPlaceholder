//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  要是用非 arc。。。。。。／／     -fno-objc-arc
 */
@interface PlaceholderTextView : UITextView

@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
@end
