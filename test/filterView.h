//
//  filterView.h
//  test
//
//  Created by simple on 16/1/25.
//  Copyright © 2016年 levy.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectItem)(NSIndexPath * indexPath);

@interface filterView : UIView
@property (strong,nonatomic) NSArray * dataArray;
@property (copy,nonatomic)selectItem selectBlock;
@end
