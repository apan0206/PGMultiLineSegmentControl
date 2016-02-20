//
//  PGMultiLineSegmentControl.m
//  TestCollectionView
//
//  Created by panda on 16/2/20.
//  Copyright © 2016年 mancai. All rights reserved.
//

#import "PGMultiLineSegmentControl.h"


#define PG_COLOR_A(R, G, B, A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:A]
#define PG_COLOR(R, G, B) PG_COLOR_A(R, G, B, 1.0)
#define kIndexBase 2000

// 默认边框颜色
#define DEFAULT_BOARD_COLOR PG_COLOR(208, 209, 211)

// 默认分隔条颜色
#define DEFAULT_DIVIDER_COLOR [UIColor lightGrayColor]

// 默认分段选中、正常颜色
#define DEFAULT_SEGMENT_NORMAL_COLOR [UIColor clearColor]
#define DEFAULT_SEGMENT_SELECTED_COLOR PG_COLOR(212, 83, 81)

// 默认分段文字选中、正常颜色
#define DEFAULT_SEGMENT_TITLE_NORMAL_COLOR [UIColor blackColor]
#define DEFAULT_SEGMENT_TITLE_SELECTED_COLOR [UIColor whiteColor]

// 默认分段文字大小
#define DEFAULT_SEGMENT_TITLE_FONT_SIZE 16.0

@interface PGCustomButton : UIButton

@end

@implementation PGCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end

@interface PGMultiLineSegmentControl()
{
    
}

@property(nonatomic, strong) NSMutableArray *segments;
@property(nonatomic, strong) NSMutableArray *dividers;
@property(nonatomic, weak) UIButton *curSelectBtn;
@property(nonatomic, strong) NSArray *items;
@end

@implementation PGMultiLineSegmentControl

+ (instancetype)multiLineSegmentControlWithItems:(NSArray *)items
{
    PGMultiLineSegmentControl *sc = [[self alloc]init];
    sc.items = items;
    return sc;
}

- (void)setup
{
    [self initConfig];
    [self setupSegment];
    [self setupDivider];
    [self setupInitSelectedSegment:self.selectedIndex];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    
    return self;
}

- (void)defaultConfig
{
    self.selectedIndex = 0;
    self.borderColor = DEFAULT_BOARD_COLOR;
    self.dividerColor = DEFAULT_DIVIDER_COLOR;
    self.segmentNormalColor = DEFAULT_SEGMENT_NORMAL_COLOR;
    self.segmentSelectedColor = DEFAULT_SEGMENT_SELECTED_COLOR;
    self.segmentTitleNormalColor = DEFAULT_SEGMENT_TITLE_NORMAL_COLOR;
    self.segmentTitleSelectedColor = DEFAULT_SEGMENT_TITLE_SELECTED_COLOR;
    self.segmentTitleFontSize = DEFAULT_SEGMENT_TITLE_FONT_SIZE;
}

- (NSMutableArray*)segments
{
    if (_segments == nil) {
        _segments = [[NSMutableArray alloc]init];
    }
    
    return _segments;
}

- (NSMutableArray*)dividers
{
    if (_dividers == nil) {
        _dividers = [[NSMutableArray alloc]init];
    }
    
    return _dividers;
}

- (void)initConfig
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

- (void)setupSegment
{
    for (int i = 0; i < [self.items count]; i++) {
        NSArray *subItems = [self.items objectAtIndex:i];
        
        NSString *title = nil;
        for (int j = 0; j < [subItems count]; j++) {
            if (j > 0) {
                title = [NSString stringWithFormat:@"%@\n%@", title, subItems[j]];
            } else {
                title = subItems[j];
            }
        }
        
        PGCustomButton *seg = [self makeBtnWithTitle:title];
        [self addSubview:seg];
        [self.segments addObject:seg];
    }
}

- (void)setupInitSelectedSegment:(NSInteger)selectIndex
{
    NSInteger index = selectIndex > self.segments.count ? 0 : selectIndex;
    
    PGCustomButton *seg = [self.segments objectAtIndex:index];
    [self setSelectBtnStyle:seg];
}

- (void)setupDivider
{
    for (int i = 0; i < [self.segments count]-1; i++) {
        UIView *divider = [[UIView alloc]init];
        divider.backgroundColor = self.dividerColor;
        [self addSubview:divider];
        [self.dividers addObject:divider];
    }
}

- (PGCustomButton*)makeBtnWithTitle:(NSString*)title
{
    PGCustomButton *btn = [PGCustomButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:self.segmentTitleFontSize]];
    [btn setTitleColor:self.segmentTitleNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.segmentTitleSelectedColor forState:UIControlStateSelected];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    
    [btn addTarget:self
            action:@selector(btnSelectFunc:)
  forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundColor:self.segmentNormalColor];
    [btn setTag:[self.segments count]+1+kIndexBase];
    
    return btn;
}

- (void)btnSelectFunc:(UIButton*)btn
{
    int selectIndex = btn.tag%kIndexBase -1;
    UIButton *selectBtn = [self.segments objectAtIndex:selectIndex];
    if (selectBtn != self.curSelectBtn) {
        [self setSelectBtnStyle:selectBtn];
        
        if ([self.delegate respondsToSelector:@selector(multiLineSegmentControl:selectedSegmentIndex:)]) {
            [self.delegate multiLineSegmentControl:self selectedSegmentIndex:selectIndex];
        }
    }
    
    self.selectedIndex = selectIndex;
}

- (void)setSelectBtnStyle:(UIButton*)selectBtn
{
    [self.curSelectBtn setSelected:NO];
    [self.curSelectBtn setBackgroundColor:self.segmentNormalColor];
    
    [selectBtn setSelected:YES];
    [selectBtn setBackgroundColor:self.segmentSelectedColor];
    self.curSelectBtn = selectBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int width = self.frame.size.width/[self.segments count];
    int height = self.frame.size.height;
    for (int i = 0; i < [self.segments count]; i++) {
        UIButton *btn = [self.segments objectAtIndex:i];
        [btn setFrame:CGRectMake(i*width, 0, width, height)];
    }
    
    for (int i = 0; i < [self.dividers count]; i++) {
        UIView *view = [self.dividers objectAtIndex:i];
        [view setFrame:CGRectMake(width*(i+1), 0, 1, height)];
    }
}


@end
