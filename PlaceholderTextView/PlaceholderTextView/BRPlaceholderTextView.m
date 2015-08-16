//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "BRPlaceholderTextView.h"
@interface BRPlaceholderTextView()<UITextViewDelegate>
@property(strong,nonatomic) UIColor *placeholder_color;
@property(strong,nonatomic) UIFont * placeholder_font;


@property(assign,nonatomic) float placeholdeWidth;

@property(copy,nonatomic) id eventBlock;
@property(copy,nonatomic) id BeginBlock;
@property(copy,nonatomic) id EndBlock;
@end
@implementation BRPlaceholderTextView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


#pragma mark - life cycle

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
    
    float left=5,top=0,hegiht=30;
    
    self.placeholdeWidth=CGRectGetWidth(self.frame)-2*left;
    
    _PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                                , _placeholdeWidth, hegiht)];
    _PlaceholderLabel.numberOfLines=0;
    _PlaceholderLabel.lineBreakMode=NSLineBreakByCharWrapping;
    
    [self addSubview:_PlaceholderLabel];
    
    self.maxTextLength=1000;
    
    
    [self defaultConfig];
    
}
-(void)dealloc{
    
    [_PlaceholderLabel removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - System Delegate
#pragma mark - custom Delegate
#pragma mark - Event response

-(void)defaultConfig
{
    self.placeholder_color = [UIColor lightGrayColor];
    self.placeholder_font  = [UIFont systemFontOfSize:14];
}

-(void)addMaxTextLengthWithMaxLength:(NSInteger)maxLength andEvent:(void (^)(BRPlaceholderTextView *text))limit
{
    _maxTextLength=maxLength;
    
    if (limit) {
        _eventBlock=limit;
        
    }
}

-(void)addTextViewBeginEvent:(void (^)(BRPlaceholderTextView *))begin{
    
    _BeginBlock=begin;
}

-(void)addTextViewEndEvent:(void (^)(BRPlaceholderTextView *))End{
    _EndBlock=End;
}

-(void)setUpdateHeight:(float)updateHeight{
    
    CGRect frame=self.frame;
    frame.size.height=updateHeight;
    self.frame=frame;
    _updateHeight=updateHeight;
}

 //供外部使用的 api

-(void)setPlaceholderFont:(UIFont *)font
{
    self.placeholder_font=font;
}
-(void)setPlaceholderColor:(UIColor *)color
{
    self.placeholder_color=color;

}
-(void)setPlaceholderOpacity:(float)opacity
{
    if (opacity<0) {
        opacity=1;
    }
    self.PlaceholderLabel.layer.opacity=opacity;
}


#pragma mark - Noti Event

-(void)textViewBeginNoti:(NSNotification*)noti{
    
    if (_BeginBlock) {
        void(^begin)(BRPlaceholderTextView*text)=_BeginBlock;
        begin(self);
    }
}
-(void)textViewEndNoti:(NSNotification*)noti{
    
    if (_EndBlock) {
        void(^end)(BRPlaceholderTextView*text)=_EndBlock;
        end(self);
    }
}

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
        
        void (^limint)(BRPlaceholderTextView*text) =_eventBlock;
        
        limint(self);
    }
}

#pragma mark - private method

+(float)boundingRectWithSize:(CGSize)size withLabel:(NSString *)label withFont:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    // CGSize retSize;
    CGSize retSize = [label boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    
    return retSize.height;
    
}

#pragma mark - getters and Setters

-(void)setText:(NSString *)tex{
    if (tex.length>0) {
        _PlaceholderLabel.hidden=YES;
    }
    [super setText:tex];
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    else
    {
        _PlaceholderLabel.text=placeholder;
        _placeholder=placeholder;
        
        float  height=  [BRPlaceholderTextView boundingRectWithSize:CGSizeMake(_placeholdeWidth, MAXFLOAT) withLabel:_placeholder withFont:_PlaceholderLabel.font];
        if (height>CGRectGetHeight(_PlaceholderLabel.frame) && height< CGRectGetHeight(self.frame)) {
            
            CGRect frame=_PlaceholderLabel.frame;
            frame.size.height=height;
            _PlaceholderLabel.frame=frame;
            
        }
    }
    
}
-(void)setPlaceholder_font:(UIFont *)placeholder_font
{
    _placeholder_font=placeholder_font;
    _PlaceholderLabel.font=placeholder_font;
}

-(void)setPlaceholder_color:(UIColor *)placeholder_color
{
    _placeholder_color=placeholder_color;
    _PlaceholderLabel.textColor=placeholder_color;
}
@end
