//
//  PGMultiLineSegmentControl.h
//
//  Created by panda on 16/2/20.
//  Copyright © 2016年 mancai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGMultiLineSegmentControl;

@protocol PGMultiLineSegmentControlDelegate <NSObject>

@optional
-(void)multiLineSegmentControl:(PGMultiLineSegmentControl*)multiLineSegmentControl selectedSegmentIndex:(NSInteger)selectedIndex;

@end

@interface PGMultiLineSegmentControl : UIView

// 例如@[@[@"xxx0", @"yyy0"], @[@"xxx1", @"yyy1"], @[@"xxx2", @"yyy2"]]
+(instancetype)multiLineSegmentControlWithItems:(NSArray *)items;

@property(nonatomic, weak) id<PGMultiLineSegmentControlDelegate> delegate;

// 边框颜色
@property(nonatomic, strong) UIColor *borderColor;

// 分隔条颜色
@property(nonatomic, strong) UIColor *dividerColor;

// 分段选中、正常颜色
@property(nonatomic, strong) UIColor *segmentNormalColor;
@property(nonatomic, strong) UIColor *segmentSelectedColor;

// 分段文字选中、正常颜色
@property(nonatomic, strong) UIColor *segmentTitleNormalColor;
@property(nonatomic, strong) UIColor *segmentTitleSelectedColor;

// 分段文字大小
@property(nonatomic, assign) float segmentTitleFontSize;

// 选中的分段索引
@property(nonatomic, assign) NSInteger selectedIndex;

// 属性设置完组装最终效果
- (void)setup;

@end
