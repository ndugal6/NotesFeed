//
//  CustomLogInViewController.swift
//  FratMap
//
//  Created by Nick Dugal on 10/1/15.
//  Copyright © 2015 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        usernameField.becomeFirstResponder()
        usernameField.returnKeyType = UIReturnKeyType.Next
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.tag = 1
        passwordField.returnKeyType = UIReturnKeyType.Go
        passwordField.tag = 2
        self.activityIndicator.center = self.view.center
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.activityIndicator)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField) {
        case usernameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            self.loginAction(self)
        default:
            dismissKeyboard()
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
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
    
    //Mark: Action
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        
        if (username.utf16.count < 4 || password.utf16.count < 5)
        {
            let alert   = UIAlertController(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in
                // Put here any code that you would like to execute when
                // the user taps that OK button (may be empty in your case if that's just
                // an informative alert)
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)                    // = UIAlertView(title: "Invalid", message: "username must be greater than 4 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            //alert.show()
            
            
        } else {
            
            self.activityIndicator.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                
                if (user != nil) {
                   // student.setName((user?.username)!)
                    //student.setEmail(user!["email"] as! String)
                    //student.setCollege(user!["college"] as! String)
                    
                    let alert = UIAlertController(title: "Success", message: "Logged in", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) { _ in
                        // Put here any code that you would like to execute when
                        // the user taps that OK button (may be empty in your case if that's just
                        // an informative alert)
                        self.performSegueWithIdentifier("loggedInSegue", sender: self)
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    //= UIAlertView(title: "Success", message: "Logged in", delegate: self, cancelButtonTitle: "OK")
                    //alert.show()
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) { _ in
                        // Put here any code that you would like to execute when
                        // the user taps that OK button (may be empty in your case if that's just
                        // an informative alert)
                    }
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    //= UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    //alert.show()
                }
                
            })
            
        }
        
    }
    
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signUpSegue", sender: self)
    }
    
}
