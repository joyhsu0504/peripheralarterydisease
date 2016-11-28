//
//  Steps.swift
//  
//
//  Created by Joy Hsu on 10/20/16.
//
//

import UIKit
import HealthKit
import PNChart

class Steps: UIViewController
{
    var chart: PNBarChart = PNBarChart.init()
    let healthStore = HKHealthStore()
    override func viewDidLoad() {
        super.viewDidLoad()
//        if checkAvailability() {
//            getStepCount(sender: self)
//        }
        
        //stepCount.text = "Test"
        checkAvailability()
        getStepCount(sender: self)
        
        //chart = PNBarChart.init(frame: self.view.frame)
        chart = PNBarChart.init(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height-10))
        self.view.addSubview(chart)
        
        // some code you can use to set the x labels and y labels
        //chart.xLabels = ["Mon", "Tues", "Weds"]
        chart.xLabels = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
        //chart.yValues = UserDefaults.standard.array(forKey: "steps")
        chart.yValues = [456.0, 839.0, 636.0, 576.0, 988.0, 1140.0, 776.0]
        chart.stroke()
    }
    
    func checkAvailability() -> Bool {
        var isAvail = true;
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount))
            let sharedObjects = NSSet(objects: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height),HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass))
            
            healthStore.requestAuthorization(toShare: sharedObjects as? Set<HKSampleType>, read: stepsCount as? Set<HKObjectType>, completion: { (success, err) in
                isAvail = success
                self.getStepCount(sender: self)
            }) 
        
        } else {
            isAvail = false
        }
        return isAvail
    }
    
    func recentSteps(completion: @escaping (Double, [Double], NSError?) -> ()) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let date = Date()
        let calendar = Calendar.current
        let curryear = calendar.component(.year, from: date)
        let currmonth = calendar.component(.month, from: date)
        let currday = calendar.component(.day, from: date)
        let last = DateComponents(calendar: nil,
                                                              timeZone: nil,
                                                              era: nil,
                                                              year: curryear,
                                                              month: currmonth,
                                                              day: currday-7,
                                                              hour: nil,
                                                              minute: nil,
                                                              second: nil,
                                                              nanosecond: nil,
                                                              weekday: nil,
                                                              weekdayOrdinal: nil,
                                                              quarter: nil,
                                                              weekOfMonth: nil,
                                                              weekOfYear: nil,
                                                              yearForWeekOfYear: nil)
        
        let lastMonth = calendar.date(from: last)!
        
        let predicate = HKQuery.predicateForSamples(withStart: lastMonth, end: Date(), options: [])
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) {
            query, results, error in
            var steps: Double = 0
            var allSteps = [Double]()
            if let myResults = results {
                for result in myResults as! [HKQuantitySample] {
                    print(myResults)
                    steps += result.quantity.doubleValue(for: HKUnit.count())
                    allSteps.append(result.quantity.doubleValue(for: HKUnit.count()))
                }
            }
            completion(steps, allSteps, error as NSError?)
            
        }
        healthStore.execute(query)
    }
    
    /*@IBOutlet weak var barChartView: BarChartView!
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.descriptionText = ""
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Steps taken")
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = BarChartData(xVals: days, dataSet: chartDataSet)
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
        barChartView.data = chartData
    }*/
    
    //@IBOutlet weak var barChartView: BarChartView!
    //@IBOutlet var stepCount : UILabel!
    //@IBOutlet var avgCount : UILabel!
    @IBAction func getStepCount(sender: AnyObject) {
        //var avgStep: Double = 0
        recentSteps() { steps, allSteps, error in
            //chart = PNBarChart.init(frame: self.view.frame)
//            var chart: PNBarChart = PNBarChart.init()
//            let healthStore = HKHealthStore()
//
//            chart = PNBarChart.init(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height-10))
//            self.view.addSubview(chart)
//            
//            // some code you can use to set the x labels and y labels
//            //chart.xLabels = ["Mon", "Tues", "Weds"]
//            chart.xLabels = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
//            chart.yValues = allSteps
//            //chart.yValues = [3.0, 5.0, 2.0]
//            chart.stroke()
//            DispatchQueue.main.sync {
//                
//                var chart: PNBarChart = PNBarChart.init()
//                let healthStore = HKHealthStore()
//                
//                chart = PNBarChart.init(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height-10))
//                self.view.addSubview(chart)
//                
//                // some code you can use to set the x labels and y labels
//                //chart.xLabels = ["Mon", "Tues", "Weds"]
//                chart.xLabels = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
//                chart.yValues = allSteps
//                //chart.yValues = [3.0, 5.0, 2.0]
//                chart.stroke()
//
//                
                //UserDefaults.standard.set(allSteps, forKey: "steps")
                //var days: [String]!
                //days = ["1", "2", "3", "4", "5", "6", "7"];
                //setChart(days, values: allSteps)
                //self.stepCount.text = "Total \(steps) steps"
                //self.avgCount.text = "Avg \(avgStep) steps"
                //print(self.stepCount.text)
//                let prefs = UserDefaults.standardUserDefaults()
//                prefs.setValue(allSteps, forKey: "stpes")
                //print("steps are " + String(steps))

            };
        }
    }




