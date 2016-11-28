//
//  FirstViewController.swift
//  PAD
//
//  Created by Joy Hsu on 11/7/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit


class FirstViewController: UIViewController {
    
    @IBOutlet weak var consentLabel: UILabel!
    @IBOutlet weak var surveyLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var isSurvey = false
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.view.tintColor = UIColor.blue // pick the color
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.view.tintColor = UIColor.blue // pick the color
        present(taskViewController, animated: true, completion: nil)
        isSurvey = true
        //surveyLabel.backgroundColor = UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.alpha = 0.0
        isSurvey = false
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension FirstViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(
        _ taskViewController: ORKTaskViewController,
        didFinishWith reason: ORKTaskViewControllerFinishReason,
        error               : Error?) {
        
        print("entering the dismiss function")
        if error != nil {
            NSLog("Error: \(error)")
        }
        else {
            // Handle results with taskViewController.result
            switch reason {
            case .completed:
                // Check if the result is the user's consent signature
                if let signatureResult =
                    taskViewController.result.stepResult(forStepIdentifier:
                        "your identifier"
                        )?.firstResult as? ORKConsentSignatureResult {
                    if signatureResult.consented {
                        // Got the user signature
                        consentLabel.backgroundColor = UIColor.blue
                    }
                }
                else {
                    // Survey forms
                }
                
            default: break
            }
        }
        
        // Dismiss the task’s view controller when the task finishes
        taskViewController.dismiss(animated: true, completion: nil)
        consentLabel.backgroundColor = UIColor.blue
        if isSurvey == true {
            surveyLabel.backgroundColor = UIColor.blue
            startButton.alpha = 1.0
        } else {
            consentLabel.backgroundColor = UIColor.blue
        }
        //startButton.alpha = 1.0
        print("hello")
    }
    /**
     Tells the delegate that the task has finished.
     
     The task view controller calls this method when an unrecoverable error occurs,
     when the user has canceled the task (with or without saving), or when the user
     completes the last step in the task.
     
     In most circumstances, the receiver should dismiss the task view controller
     in response to this method, and may also need to collect and process the results
     of the task.
     
     @param taskViewController  The `ORKTaskViewController `instance that is returning the result.
     @param reason              An `ORKTaskViewControllerFinishReason` value indicating how the user chose to complete the task.
     @param error               If failure occurred, an `NSError` object indicating the reason for the failure. The value of this parameter is `nil` if `result` does not indicate failure.
     */
    
    
    /*
     public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
     
     }
     */
    /*
     func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
     //Handle results with taskViewController.result
     taskViewController.dismiss(
     animated: true, completion: nil)
     }
     */
    
    
}

