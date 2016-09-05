//
//  CustomTableViewCell.h
//  TableViewScrollDeleteCell
//
//  Created by 高洁 on 16/8/16.
//  Copyright © 2016年 高洁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^handleGestureEndedBlock) (BOOL isDelete,NSIndexPath *incex);

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, copy) handleGestureEndedBlock cellBlock;

@end
