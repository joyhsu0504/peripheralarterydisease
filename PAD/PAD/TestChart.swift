//
//  TestChart.swift
//  PAD
//
//  Created by Joy Hsu on 10/27/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit
import HealthKit

/*protocol AnimatableChart {
    func animateWithDuration(animationDuration: TimeInterval)
}

extension ORKLineGraphChartView : AnimatableChart {}*/

class TestChart: UIViewController {
    
    //@IBOutlet weak var lineGraphView: ORKLineGraphChartView!
    
    let lineGraphView = LineGraphDataSource()

    //   let discreteGraphDataSource = DiscreteGraphDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //lineGraphView = ORKLineGraphChartView()
        let lineGraphView = ORKLineGraphChartView()
        lineGraphView.dataSource = LineGraphDataSource()
//        lineGraphView.dataSource = self
        
        lineGraphView.showsHorizontalReferenceLines = true
        lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.axisColor = UIColor.blue
        lineGraphView.verticalAxisTitleColor = UIColor.darkGray
        //lineGraphView.showsHorizontalReferenceLines = true
        //lineGraphView.showsVerticalReferenceLines = true
        lineGraphView.scrubberLineColor = UIColor.lightGray
        //CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100))
        lineGraphView.frame = CGRect(origin: CGPoint(x: 10, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        
        self.view.addSubview(lineGraphView)
        
        
//        lineGraphView.reloadData()
//        lineGraphView.reloadInputViews()
    }
    
//    @IBOutlet weak var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let lineChartView = ORKGraphChartView
//        lineChartView.dataSource = self
//        
//        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
//        UITableViewHeaderFooterView.appearance().tintColor = UIColor.white
//        tableView.tableFooterView = UIView(frame: rect)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.reloadDashboardData()
//    }
//    
//    private func reloadDashboardData() {
//        //let daysDataDicts = dashboardData!["daysData"] as? [[String: AnyObject]] {
//        let daysDataList = [1, 2, 3, 4, 5, 6, 7]
//        
//        var dataSource = PeriodicLineGraphDataSource()
//        // stablish the type
//        dataSource.type = "day"
//                
//        // clean previous loaded data
//        dataSource.plotPoints.removeAll()
//            
//        for dayData in daysDataList {
//            self.dataSource.plotPoints.append(dayData as! CGFloat)
//        }
//        self.tableView.reloadData()
//
//    }
}

