//
//  LineGraphDataSource.swift
//  PAD
//
//  Created by Joy Hsu on 10/27/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

class LineGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {//ORKGraphChartViewDataSource {

    let prefs = UserDefaults.standard
//    let allSteps = prefs.stringForKey("steps")
    
    
    
    var plotPoints =
        [
//            ORKValueRange(value: allSteps[0]),
//            ORKValueRange(value: allSteps[1]),
//            ORKValueRange(value: allSteps[2]),
//            ORKValueRange(value: allSteps[3]),
//            ORKValueRange(value: allSteps[4]),
//            ORKValueRange(value: allSteps[5]),
//            ORKValueRange(value: allSteps[6])
            
            ORKValueRange(value: 20),
            ORKValueRange(value: 45),
            ORKValueRange(value: 15),
            ORKValueRange(value: 8),
            ORKValueRange(value: 30),
            ORKValueRange(value: 35),
            ORKValueRange(value: 20)
        ]
    
    // Required methods
    
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        print("plot index is \(plotIndex)")
        print("point index is \(plotPoints[pointIndex])")
        return plotPoints[pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints.count
//        return 1
    }
    
//    func numberOfPlotsIngraphChartView(graphChartView: ORKGraphChartView) -> Int {
//        return plotPoints.count
//    }
    
    
    public func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
//        return plotPoints.count
        return 1
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        return UIColor.red
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, drawsPointIndicatorsForPlotIndex plotIndex: Int) -> Bool {
        return true
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, fillColorForPlotIndex plotIndex: Int) -> UIColor {
        return UIColor.blue
    }

    
    // Provides titles for x axis
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
    
}
