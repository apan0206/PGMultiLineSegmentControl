//
//  ViewController.m
//  TestMultilineSegmentControl
//
//  Created by panda on 16/2/20.
//  Copyright © 2016年 mancai. All rights reserved.
//

#import "ViewController.h"
#import "PGMultiLineSegmentControl.h"

@interface ViewController ()<PGMultiLineSegmentControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    PGMultiLineSegmentControl *segmentControl = [PGMultiLineSegmentControl multiLineSegmentControlWithItems:@[@[@"今天", @"2016-02-20"], @[@"明天", @"2016-02-21"], @[@"后天", @"2016-02-22"]]];
    segmentControl.selectedIndex = 1;
    segmentControl.delegate = self;
    segmentControl.segmentTitleFontSize = 16.0f;
//    segmentControl.segmentSelectedColor = [UIColor blueColor];
//    segmentControl.segmentTitleSelectedColor = [UIColor redColor];
//    segmentControl.segmentTitleNormalColor = [UIColor greenColor];
    [segmentControl setBounds:CGRectMake(0, 0, 360, 60)];
    [segmentControl setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, 200)];
    [segmentControl setup];
    [self.view addSubview:segmentControl];
}

- (void)multiLineSegmentControl:(PGMultiLineSegmentControl *)multiLineSegmentControl selectedSegmentIndex:(NSInteger)selectedIndex
{
    NSLog(@"multiline segment control selected index: %ld", selectedIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
