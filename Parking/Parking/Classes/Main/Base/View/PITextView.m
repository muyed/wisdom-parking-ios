//
//  PITextView.m
//  Parking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PITextView.h"

@interface PITextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation PITextView

- (UILabel *)placeholderLabel {
    
    if (!_placeholderLabel) {
        
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 5;
        placeholderLabel.y = 8;
        
        [self addSubview:placeholderLabel];
        
        _placeholderLabel = placeholderLabel;
        
    }
    
    return _placeholderLabel;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setup];
    
}

- (void)setup {
    
    //-- 垂直方向永远有弹簧效果
    self.alwaysBounceVertical = YES;
    //-- 默认文字大小
    self.font = [UIFont systemFontOfSize:16];
    //-- 占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
    
    //-- 监听文字变化
    [PINotification addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    
    [PINotification removeObserver:self];
}

- (void)textChange {
    
    
    self.placeholderLabel.hidden = self.hasText;
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    
    [self.placeholderLabel sizeToFit];
    
}
#pragma mark -- 重写setter方法
- (void)setPlaceholder:(NSString *)placeholder {
    
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    
    [super setText:text];

    
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    
    [super setAttributedText:attributedText];
    
    
    [self textChange];
}

@end
