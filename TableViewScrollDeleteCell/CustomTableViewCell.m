//
//  CustomTableViewCell.m
//  TableViewScrollDeleteCell
//
//  Created by 高洁 on 16/8/16.
//  Copyright © 2016年 高洁. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

{
    UIView *snapView;
}

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _containerView.layer.cornerRadius = 4;
    _containerView.layer.masksToBounds = YES;
    
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture:)];
    [self.contentView addGestureRecognizer:longPress];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)handleLongpressGesture:(UILongPressGestureRecognizer *)gesture
{
    CGPoint startPoint = CGPointZero;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            
        {
            snapView = [_containerView snapshotViewAfterScreenUpdates:NO];
            startPoint = [gesture locationInView:self.contentView];
            //重设layer锚点
            snapView.layer.anchorPoint = CGPointMake(startPoint.x / snapView.layer.frame.size.width - 0.1, startPoint.y / snapView.layer.frame.size.height - 0.1);
            snapView.frame = _containerView.frame;
            snapView.transform = CGAffineTransformMakeRotation(M_PI / 30);
            [self.contentView addSubview:snapView];
            self.containerView.hidden = YES;
            self.shadowView.hidden = YES;
        }
            break;
            case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [gesture locationInView:self.contentView];
            [UIView animateWithDuration:0.05 animations:^{
                snapView.layer.position = changePoint;
            }];
        }
            break;
            case UIGestureRecognizerStateEnded:
            
        {
            CGPoint endPoint = [gesture locationInView:self.contentView];
            if (endPoint.x > self.contentView.bounds.size.width - 50)
            {
                if (self.cellBlock)
                {
                    self.cellBlock(YES,self.cellIndex);
                }
            }
            else
            {
                if (self.cellBlock) {
                    self.cellBlock(NO, self.cellIndex);
                }
                
            }
            [snapView removeFromSuperview];
            self.containerView.hidden = NO;
            self.shadowView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}


@end
