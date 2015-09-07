//
//  LaunchViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/21.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var thirdNumberTextField: UITextField!
    @IBOutlet weak var forthNumberTextField: UITextField!
    
    
    @IBAction func enterProgram(sender: AnyObject) {
        let setting = Setting()
        let password = setting.launchPassword
        
        
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
        setUpTextField()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 1 {
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("aa")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // 自定义
    
    func setUpTextField() {
        self.firstNumberTextField.delegate = self
        self.secondNumberTextField.delegate = self
        self.thirdNumberTextField.delegate = self
        self.forthNumberTextField.delegate = self
        
        self.firstNumberTextField.keyboardType = UIKeyboardType.NumberPad
        self.secondNumberTextField.keyboardType = UIKeyboardType.NumberPad
        self.thirdNumberTextField.keyboardType = UIKeyboardType.NumberPad
        self.forthNumberTextField.keyboardType = UIKeyboardType.NumberPad
        
        self.firstNumberTextField.tintColor = UIColor.clearColor()
        self.secondNumberTextField.tintColor = UIColor.clearColor()
        self.thirdNumberTextField.tintColor = UIColor.clearColor()
        self.forthNumberTextField.tintColor = UIColor.clearColor()
        
        self.firstNumberTextField.secureTextEntry = true
        
        self.firstNumberTextField.becomeFirstResponder()
        self.firstNumberTextField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
        self.secondNumberTextField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
        self.thirdNumberTextField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
        self.forthNumberTextField.addTarget(self, action: "textChanged:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textChanged(sender: AnyObject) {
        if sender.tag == 1 {
            self.secondNumberTextField.becomeFirstResponder()
        } else if sender.tag == 2 {
            self.thirdNumberTextField.becomeFirstResponder()
        } else if sender.tag == 3 {
            self.forthNumberTextField.becomeFirstResponder()
        }
    }
    

}











