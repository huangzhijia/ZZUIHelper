//
//  ZZUIButton.m
//  ZZUIHelper
//
//  Created by 李伯坤 on 2017/2/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "ZZUIButton.h"

@implementation ZZUIButton
@synthesize events = _events;
@synthesize properties = _properties;

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [super properties];

        ZZProperty *title = [[ZZProperty alloc] initWithPropertyName:@"title" type:ZZPropertyTypeString defaultValue:@""];
        [title setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTitle:%@ forState:UIControlStateNormal", value];
        }];
        ZZProperty *titleColor = [[ZZProperty alloc] initWithPropertyName:@"titleColor" type:ZZPropertyTypeObject defaultValue:@"[UIColor blackColor]"];
        [titleColor setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setTitleColor:%@ forState:UIControlStateNormal", value];
        }];
        ZZProperty *image = [[ZZProperty alloc] initWithPropertyName:@"image" type:ZZPropertyTypeObject defaultValue:@""];
        [image setPropertyCodeByValue:^NSString *(id value) {
            return [NSString stringWithFormat:@"setImage:%@ forState:UIControlStateNormal", value];
        }];
        ZZPropertyGroup *group = [[ZZPropertyGroup alloc] initWithGroupName:@"UIButton" properties:@[title, titleColor, image]];
        [_properties addObject:group];
    }
    return _properties;
}

- (NSArray *)events
{
    if (!_events) {
        ZZEvent *touchDown = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDown" selected:NO];
        ZZEvent *touchDownRepeat = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchDownRepeat" selected:NO];
        ZZEvent *touchUpInside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpInside" selected:YES];
        ZZEvent *touchUpOutside = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchUpOutside" selected:NO];
        ZZEvent *touchCancel = [[ZZEvent alloc] initWithEventType:@"UIControlEventTouchCancel" selected:NO];
        _events = @[touchDown, touchDownRepeat, touchUpInside, touchUpOutside, touchCancel];
    }
    return _events;
}


@end
