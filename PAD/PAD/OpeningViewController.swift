//
//  OpeningViewController.swift
//  PAD
//
//  Created by Rohun Saxena on 11/2/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import UIKit
import ResearchKit


class OpeningViewController: UIViewController {

    @IBOutlet var message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = "Do the consent form plz"
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.view.tintColor = UIColor.blue // pick the color
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
        
        
        let taskViewController2 = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController2.view.tintColor = UIColor.blue // pick the color
        taskViewController2.delegate = self
        present(taskViewController2, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OpeningViewController : ORKTaskViewControllerDelegate {
    
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
        print("hello")
    }
}
