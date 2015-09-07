//
//  CreatePasswordViewController.swift
//  PrivatePhoto
//
//  Created by Mark on 15/9/6.
//  Copyright (c) 2015年 codermango. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func createNewPassword(sender: AnyObject) {
        let setting = Setting()
        let newPassword = passwordTextField.text
        setting.createPassword(newPassword)
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
