//
//  LaunchViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/21.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var thirdNumberTextField: UITextField!
    @IBOutlet weak var forthNumberTextField: UITextField!
    
    
    @IBAction func enterProgram(sender: AnyObject) {
        let setting = Setting()
        let password = setting.getLaunchPassword()
        
        
        let input = firstNumberTextField.text + secondNumberTextField.text + thirdNumberTextField.text + forthNumberTextField.text
        if input == password {
            self.performSegueWithIdentifier("toHome", sender: self)
        } else {
            let alertController = UIAlertController(title: "", message: "密码错误", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
