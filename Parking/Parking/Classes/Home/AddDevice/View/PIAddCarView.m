//
//  PIAddCarView.m
//  Parking
//
//  Created by apple on 2018/4/1.
//  Copyright © 2018年 GM. All rights reserved.
//

#import "PIAddCarView.h"

#define kZJPasswordBoxSpace 8 * Scale_X
#define kZJPasswordBoxMargin 18 * Scale_X

#define kZJPasswordBoxWidth 42 * Scale_X
#define kZJPasswordBoxNumber 6

@interface PIAddCarView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray <UILabel*> *labelBoxArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *currentText;
///-- 汉字
@property (nonatomic, strong) UITextField *titleField;

@end

@implementation PIAddCarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, 50 * Scale_X);
        
        self.titleField.frame = CGRectMake(kZJPasswordBoxMargin, 0, kZJPasswordBoxWidth, kZJPasswordBoxWidth);
        self.titleField.textColor = UIColorFromRGB(0x444444);
        self.titleField.layer.borderWidth = 0.5f;
        self.titleField.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
        self.titleField.layer.cornerRadius = 2 * Scale_X;
        self.titleField.layer.masksToBounds = YES;
        self.titleField.textAlignment = NSTextAlignmentCenter;
        self.titleField.font = PISYS_FONT(25 * Scale_X);
        
        [self addSubview:self.titleField];
        [self addSubview:self.textField];
        [self.titleField becomeFirstResponder];
        [self initData];
        
    }
    
    return self;
}

- (void)initData
{
    self.currentText = @"";
    for (int i = 0; i < kZJPasswordBoxNumber; i ++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kZJPasswordBoxMargin + kZJPasswordBoxWidth + kZJPasswordBoxSpace + i * (kZJPasswordBoxWidth + kZJPasswordBoxSpace), 0, kZJPasswordBoxWidth, kZJPasswordBoxWidth)];
        label.textColor = UIColorFromRGB(0x444444);
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
        label.layer.cornerRadius = 2 * Scale_X;
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = PISYS_FONT(25);
        label.tag = i;
        
        [self addSubview:label];
        
        [self.labelBoxArray addObject:label];
    }
}

- (void)startShakeViewAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    shake.values = @[@0,@-10,@10,@-10,@0];
    shake.additive = YES;
    shake.duration = 0.25;
    [self.layer addAnimation:shake forKey:@"shake"];
}

- (void)textDidChanged:(UITextField *)textField
{
    
    NSLog(@"-----");
    
    if (textField.tag) {
        
        if (textField.text.length == 1 && [textField.text isChinese]) {
            
            [self.titleField resignFirstResponder];
            
            [self.textField becomeFirstResponder];
            
        }else {
            
            self.titleField.text = @"";
            
        }
    }else {
        
        textField.keyboardType = UIKeyboardTypeDefault;
        if (textField.text.length > kZJPasswordBoxNumber)
        {
            textField.text = [textField.text substringToIndex:kZJPasswordBoxNumber];
        }
        
        [self updateLabelBoxWithText:textField.text];
        if (textField.text.length == kZJPasswordBoxNumber)
        {
            if (self.completionBlock)
            {
                self.completionBlock([NSString stringWithFormat:@"%@%@", self.titleField.text,self.textField.text]);
            }
        }
    }
    
    
}

#pragma mark - Public

- (void)updateLabelBoxWithText:(NSString *)text
{
    //输入时
    if (text.length > self.currentText.length) {
        for (int i = 0; i < kZJPasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length - 1)
            {
                //特殊字符不居中显示，设置文本向下偏移
                
                NSString *subStr = [text substringWithRange:NSMakeRange(i, 1)];
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:subStr attributes:@{NSBaselineOffsetAttributeName:@(0)}];
                label.attributedText = att1;
            }
            else if (i == text.length - 1)
            {
                label.text = [text substringWithRange:NSMakeRange(i, 1)];
                [self animationShowTextInLabel: label];
            }
            else
            {
                label.text = @"";
            }
        }
    }
    //删除时
    else
    {
        for (int i = 0; i < kZJPasswordBoxNumber; i++)
        {
            UILabel *label = self.labelBoxArray[i];
            if (i < text.length)
            {
                //特殊字符不居中显示，设置文本向下偏移
                NSString *subStr = [text substringWithRange:NSMakeRange(i, 1)];
                
                NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:subStr attributes:@{NSBaselineOffsetAttributeName:@(0)}];
                label.attributedText = att1;
            }
            else
            {
                label.text = @"";
                
                NSLog(@"%@", label.text);
                
            }
        }
        
        
        
    }
    self.textField.text = text;
    NSLog(@"%@", text);
    if (self.textField.text.length == 0) {
        
        //self.titleField.text = @"";
        [self.textField resignFirstResponder];
        [self.titleField becomeFirstResponder];
    }
    
    self.currentText = text;
}

- (void)animationShowTextInLabel:(UILabel *)label
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //特殊字符不居中显示，设置文本向下偏移
        NSString *subStr = [self.textField.text substringWithRange:NSMakeRange(label.tag, 1)];
        NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:subStr attributes:@{NSBaselineOffsetAttributeName:@(0)}];
        label.attributedText = att1;
    });
}

- (void)didInputPasswordError
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startShakeViewAnimation];
        self.textField.text = @"";
        [self updateAllLabelTextToNone];
    });
}

- (void)updateAllLabelTextToNone
{
    for (int i = 0; i < kZJPasswordBoxNumber; i++)
    {
        UILabel *label = self.labelBoxArray[i];
        label.text = @"";
    }
}

- (void)transformTextInTextField:(UITextField *)textField
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        textField.text = @"*";
    });
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark - Getter/Setter

- (NSMutableArray *)labelBoxArray
{
    if (!_labelBoxArray)
    {
        _labelBoxArray = [NSMutableArray array];
    }
    return _labelBoxArray;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] init];
        [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.delegate = self;
        _textField.tag = 0;
    }
    return _textField;
}

- (UITextField *)titleField {
    
    if (!_titleField)
    {
        _titleField = [[UITextField alloc] init];
        [_titleField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
        //_titleField.keyboardType = UIKeyboardTypeNumberPad;
        _titleField.delegate = self;
        _titleField.tag = 1;
        _titleField.tintColor = [UIColor clearColor];
    }
    return _titleField;
}
@end
