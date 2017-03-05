//
//  ZZUITextField.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUITextField.h"
#import "ZZUITextFieldDelegate.h"

@implementation ZZUITextField
@synthesize properties = _properties;
@synthesize delegates = _delegates;

- (NSArray *)delegates
{
    if (!_delegates) {
        ZZUITextFieldDelegate *delegate = [[ZZUITextFieldDelegate alloc] init];
        _delegates = @[delegate];
    }
    return _delegates;
}

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];
        ZZProperty *text = [[ZZProperty alloc] initWithPropertyName:@"text" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *placeholder = [[ZZProperty alloc] initWithPropertyName:@"placeholder" type:ZZPropertyTypeString defaultValue:@""];
        ZZProperty *font = [[ZZProperty alloc] initWithPropertyName:@"font" type:ZZPropertyTypeString defaultValue:@"[UIFont systemFontOfSize:13]"];
        ZZProperty *textColor = [[ZZProperty alloc] initWithPropertyName:@"textColor" type:ZZPropertyTypeObject defaultValue:@"[UIColor blackColor]"];
        ZZProperty *textAlignment = [[ZZProperty alloc] initWithPropertyName:@"textAlignment" type:ZZPropertyTypeObject defaultValue:@"NSTextAlignmentLeft"];
        ZZProperty *delegate = [[ZZProperty alloc] initWithPropertyName:@"delegate" type:ZZPropertyTypeObject defaultValue:@"self" selecetd:YES];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UITextField" properties:@[text, placeholder, font, textColor, textAlignment] privateProperties:@[delegate]];
        [_properties addObject:group];
    }
    return _properties;
}

@end
