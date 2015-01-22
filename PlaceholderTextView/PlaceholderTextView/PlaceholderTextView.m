//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>

//最大长度设置
@property(assign,nonatomic) NSInteger maxTextLength;


@property(copy,nonatomic) id eventBlock;
@property(copy,nonatomic) id BeginBlock;
@property(copy,nonatomic) id EndBlock;



@end
@implementation PlaceholderTextView
- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    //UITextViewTextDidBeginEditingNotification
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewBeginNoti:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    //UITextViewTextDidEndEditingNotification
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEndNoti:) name:UITextViewTextDidEndEditingNotification object:self];

    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    _PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    _PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    _PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:_PlaceholderLabel];
    _PlaceholderLabel.text=self.placeholder;
    
    self.maxTextLength=1000;

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    else
        _PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;

    
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _PlaceholderLabel.textColor=placeholderColor;
    _placeholderColor=placeholderColor;
}
-(void)setPlaceholderFont:(UIFont *)placeholderFont{
    _PlaceholderLabel.font=placeholderFont;
    _placeholderFont=placeholderFont;
}
-(void)setText:(NSString *)tex{
    if (tex.length>0) {
        _PlaceholderLabel.hidden=YES;
    }
    [super setText:tex];
}

#pragma mark---一些通知
-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _PlaceholderLabel.hidden=YES;
    }
    else{
        _PlaceholderLabel.hidden=NO;
    }
    
    
    if (_eventBlock && self.text.length > self.maxTextLength) {
        
        void (^limint)(PlaceholderTextView*text) =_eventBlock;
        
        limint(self);
    }
}


-(void)textViewBeginNoti:(NSNotification*)noti{
    
    if (_BeginBlock) {
        void(^begin)(PlaceholderTextView*text)=_BeginBlock;
        begin(self);
    }
}
-(void)textViewEndNoti:(NSNotification*)noti{
 
    if (_EndBlock) {
        void(^end)(PlaceholderTextView*text)=_EndBlock;
        end(self);
    }
}



#pragma mark----使用block 代理 delegate
-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void (^)(PlaceholderTextView *))limit{
    _maxTextLength=maxLength;
    
    if (limit) {
        _eventBlock=limit;

    }
}

-(void)addTextViewBeginEvent:(void (^)(PlaceholderTextView *))begin{
    
    _BeginBlock=begin;
}

-(void)addTextViewEndEvent:(void (^)(PlaceholderTextView *))End{
    _EndBlock=End;
}



-(void)setUpdateHeight:(float)updateHeight{
    
    CGRect frame=self.frame;
    frame.size.height=updateHeight;
    self.frame=frame;
    _updateHeight=updateHeight;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_PlaceholderLabel removeFromSuperview];
    
}

@end
