//
//  LaunchViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/8/21.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func enterProgram(sender: AnyObject) {
        let setting = Setting()
        let password = setting.getPassword()
        
        
        let input = passwordTextField.text
        if input == password {
            self.performSegueWithIdentifier("toHome", sender: self)

        } else {
            let alertController = UIAlertController(title: "", message: "密码错误", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            passwordTextField.text = ""
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        println("ddddddd")
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
        if range.location >= 4 {
            return false
        } else {
            return true
        }
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
        self.passwordTextField.delegate = self
        
        self.passwordTextField.becomeFirstResponder()
        self.passwordTextField.keyboardType = UIKeyboardType.NumberPad
        self.passwordTextField.tintColor = UIColor.clearColor()
        self.passwordTextField.secureTextEntry = true
        
    }

    

}











