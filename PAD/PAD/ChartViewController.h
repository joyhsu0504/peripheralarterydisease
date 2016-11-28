//
//  ChartViewController.h
//  PAD
//
//  Created by Sherman Leung on 11/17/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

#ifndef ChartViewController_h
#define ChartViewController_h

#endif /* ChartViewController_h */

#import "PNChart.h"

@interface ChartViewController : UIViewController

@property PNBarChart* barChart;

    - (void) graphValues:(NSArray*)xValues yValues:(NSArray*) yValues;
@end

