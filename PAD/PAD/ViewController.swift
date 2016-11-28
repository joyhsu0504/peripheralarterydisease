//
//  ViewController.swift
//  PAD
//
//  Created by Joy Hsu on 10/3/16.
//  Copyright © 2016 Joy Hsu. All rights reserved.
//

import UIKit
import ResearchKit
import CareKit
import Firebase
import FirebaseAuth
import FirebaseAnalytics

class ViewController: UIViewController {
    var store: OCKCarePlanStore?
    @IBAction func tasksTapped(_ sender: AnyObject) {
        let fileManager = FileManager.default
        
        guard let documentDirectory =   fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("*** Error: Unable to get the document directory! ***")
        }
        
        let storeURL = documentDirectory.appendingPathComponent("MyCareKitStore")
        if !fileManager.fileExists(atPath: storeURL.path) {
            try! fileManager.createDirectory(at: storeURL,
                                             withIntermediateDirectories: true, attributes: nil)
        }
        
        store = OCKCarePlanStore(persistenceDirectoryURL: storeURL)
        
        
        store?.activity(forIdentifier: "Steps") { (success, activityOrNil, errorOrNil) -> Void in
            guard success else {
                // perform real error handling here.
                fatalError("*** An error occurred \(errorOrNil?.localizedDescription) ***")
            }
            
            if let activity = activityOrNil {
                
                // the activity already exists.
                
            } else {
                let startDay = NSDateComponents(year: 2016, month: 3, day: 15)
                let twiceADay = OCKCareSchedule.dailySchedule(withStartDate: startDay as DateComponents, occurrencesPerDay: 2)
                let medication = OCKCarePlanActivity(
                    identifier: "Steps",
                    groupIdentifier: nil,
                    type: .intervention,
                    title: "Steps",
                    text: "10,000 Steps",
                    tintColor: nil,
                    instructions: "Data shows the more you walk the less pain you have and the better quality of living. So step outside and enjoy the fresh air and birds chirping by walking your way to a PAD free life",
                    imageURL: nil,
                    schedule: twiceADay,
                    resultResettable: true,
                    userInfo: nil)
                
                self.store?.add(medication, completion: { (bool, error) in
                }) // don't know why it wanted self here
                
            }
        }
        
        
        let careCardViewController = OCKCareCardViewController(carePlanStore: store!)
        //        self.present(careCardViewController, animated: true)
        if let nav = self.navigationController {
            nav.pushViewController(careCardViewController, animated: true)
            print("got it")
        }
        else{
            print("no nav")
        }
        //crashes after this point
    }
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FIRApp.configure()
//        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
//            guard var User = user else { return }
//            //user = User(authData: user)
//        }
//        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func viewDidAppear() {
        let registrationTitle = NSLocalizedString("Registration", comment: "")
        let passcodeValidationRegex = "^(?=.*\\d).{4,8}$"
        let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 and 8 digits long and include at least one numeric character.", comment: "")
        let registrationOptions: ORKRegistrationStepOption = [.includeGivenName, .includeFamilyName, .includeGender, .includeDOB]
        let registrationStep = ORKRegistrationStep(identifier: String("identification"), title: registrationTitle, text: "tesing", passcodeValidationRegex: passcodeValidationRegex, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
 
        let taskreg = ORKOrderedTask(identifier: "Join", steps: [registrationStep])
        let taskViewController = ORKTaskViewController(task: taskreg, taskRun: nil)
        //self.present(taskViewController, animated: true, completion: {() -> Void in
        //})
        //taskViewController.delegate = self
        self.present(taskViewController, animated: true, completion: {() -> Void in
        //})

        

    }*/


}

extension ViewController : ORKTaskViewControllerDelegate {
    
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

