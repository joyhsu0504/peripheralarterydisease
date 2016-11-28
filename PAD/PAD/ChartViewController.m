//
//  ChartViewController.m
//  PAD
//
//  Created by Sherman Leung on 11/17/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChartViewController.h"
#import "PNChart.h"

@implementation ChartViewController

- (void) viewDidLoad {
    
//    self.newStepController = [[Steps alloc]init];
//    [self.newStepController checkAvailability()];
//    [self.newStepController getStepCount(sender: self)];
//    
//    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *steps = [userDefaults objectForKey:@"steps"];
    
    //For Bar Chart initialization - you can use the BarChartFormattor to get more fancy!
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    
    // You can comment out/remove the below - this is just to show proof of concept
    [self.barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    //[self.barChart setYValues:@[@535,  @660, @345, @823, @715]];
    [self.barChart setYValues:steps];
    [self.barChart strokeChart];
    //[self.barChart backgroundColor: [UIColor blueColor]];
    [self.view addSubview: self.barChart];
}

// Pass in an array of strings for xValues and an array of numbers for the yvalues
- (void) graphValues:(NSArray *)xValues yValues:(NSArray *)yValues {
    [self.barChart setXLabels:xValues];
    [self.barChart setYValues:yValues];
    [self.barChart strokeChart];
    [self.view addSubview: self.barChart];
}
@end
