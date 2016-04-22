//
//  SIgnUpViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 2/01/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func cancelButton(sender: UIButton) {
        self.performSegueWithIdentifier("backToLogin", sender: self)
    }
    
    
    var picker: UIPickerView = UIPickerView()
    let activeArray = ["Pledge", "Active"]
    var schoolArray = ["LSU","Ull", "UGA", "SouthEastern"]
    var collegePicked = (0, "")
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.emailField.becomeFirstResponder()
        setup()
        self.activityIndicator.center = self.view.center
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityIndicator)
        
        
        
    }
    
    func setup() {

        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        phoneField.delegate = self
        
        emailField.returnKeyType = UIReturnKeyType.Next
        usernameField.returnKeyType = UIReturnKeyType.Next
        passwordField.returnKeyType = UIReturnKeyType.Next
        phoneField.returnKeyType = UIReturnKeyType.Next
        
        emailField.tag = 1
        usernameField.tag = 2
        passwordField.tag = 3
        phoneField.tag = 4

        
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField) {
        case emailField:
            usernameField.becomeFirstResponder()
        case usernameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            phoneField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
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
    
    //MARK: Picker
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schoolArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolArray.count
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collegePicked.0 = row
    }
    
    
    //MARK: Actions
    @IBAction func signupAction(sender: AnyObject) {
        
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        let email = self.emailField.text!
        let phoneNumber = self.phoneField.text!
        
        if (collegePicked.0 == 0) {
            collegePicked.1 = "AGR"
        }
        else {
            collegePicked.1 = "Sigma Nu"
        }
        
        if (username.utf16.count < 4 || password.utf16.count < 5)
        {
            let alert   = UIAlertController(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                // Put here any code that you would like to execute when
                // the user taps that OK button (may be empty in your case if that's just
                // an informative alert)
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (email.utf16.count < 8) {
            
            let alert   = UIAlertController(title: "Invalid", message: "Enter a valid email", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                // Put here any code that you would like to execute when
                // the user taps that OK button (may be empty in your case if that's just
                // an informative alert)
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.activityIndicator.startAnimating()
            
            let newUser = PFUser()
            newUser["username"] = username
            newUser.username = username
            newUser.password = password
            newUser.email = email
            newUser["phoneNumber"] = phoneNumber
            newUser["favorites"] = ""
            
            
            newUser.signUpInBackgroundWithBlock({ (success, error) -> Void in
                self.activityIndicator.stopAnimating()
                
                if (error != nil) {
                    let alert   = UIAlertController(title: "Error", message: "Uh-Oh, there was an error. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) { _ in
                        // Put here any code that you would like to execute when
                        // the user taps that OK button (may be empty in your case if that's just
                        // an informative alert)
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                } else {
                    let alert   = UIAlertController(title: "Success", message: "Signed Up", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { Void in
                        
                        //
                        
                        // Put here any code that you would like to execute when
                        // the user taps that OK button (may be empty in your case if that's just
                        // an informative alert)
                        self.performSegueWithIdentifier("backToLogin", sender: self)
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            })
        }
        
    }
    
}


