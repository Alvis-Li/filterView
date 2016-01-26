//
//  CollectionViewCell.m
//  collectionView
//
//  Created by shikee_app05 on 14-12-10.
//  Copyright (c) 2014年 shikee_app05. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Masonry.h"
@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if (!_text) {
            self.text = [UILabel new];
            _text.backgroundColor = [UIColor whiteColor];
            _text.textAlignment = NSTextAlignmentCenter;
             [self.contentView addSubview:_text];
            [_text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

-(void)setCellSelected:(BOOL)cellSelected{
    _cellSelected = cellSelected;
    if (cellSelected) {
        _text.layer.borderColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.0 alpha:1.0].CGColor;
        _text.layer.borderWidth = 1;
        _text.textAlignment = NSTextAlignmentCenter;
        _text.textColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.0 alpha:1.0];
    }else {
        _text.layer.borderColor = [UIColor whiteColor].CGColor;
        _text.layer.borderWidth = 1;
        _text.textAlignment = NSTextAlignmentCenter;
        _text.textColor = [UIColor blackColor];
    }
}

@end
