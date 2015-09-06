//
//  CreatePasswordViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/9/6.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var thirdNumberTextField: UITextField!
    @IBOutlet weak var forthNumberTextField: UITextField!
    
    @IBAction func createNewPassword(sender: AnyObject) {
        let setting = Setting()
        let newPassword = firstNumberTextField.text + secondNumberTextField.text + thirdNumberTextField.text + forthNumberTextField.text
        setting.createPassword(newPassword)
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
