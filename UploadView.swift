//
//  UploadView.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/11/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

class UploadView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBAction func uploadButtonPressed(sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.uploadStatusLabel.hidden = true

        let newNote: PFObject = PFObject(className: courseTextField.text!.uppercaseString)
        newNote["Class"] = classTextField.text!
        newNote["Professor"] = professorTextField.text!
        newNote["Semester"] = semesterTextField.text!
        newNote["Year"] = yearTextField.text!
    

        var compress: CGFloat = 1.0
        let img = imageView.image!
        var imgDat = UIImageJPEGRepresentation(img, compress)
        while (imgDat?.length > 10485760) {
            compress -= 0.05
            imgDat = UIImageJPEGRepresentation(img, compress)
        }
        let imageFile: PFFile = PFFile(data: imgDat!)!
        newNote["Note"] = imageFile
        
        newNote.saveInBackgroundWithBlock { (true, error) in
            self.activityIndicator.stopAnimating()
            if (error == nil) {
                self.uploadStatusLabel.hidden = false
                self.uploadStatusLabel.text = "Success"
                self.uploadStatusLabel.textColor = UIColor.greenColor()
            }
            else {
                self.uploadStatusLabel.hidden = false
                self.uploadStatusLabel.text = "Upload Failed :("
                self.uploadStatusLabel.textColor = UIColor.redColor()
            }
       
        }
//        do {
//            
//            try newNote.save() } catch { }
        
        
    }
    
    //Create Instance of uipicker within class scope
    let imagePicker = UIImagePickerController();

    
    //Need to set delegate to itself before showing the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.uploadStatusLabel.hidden = true
        imagePicker.delegate = self
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
    }
    
    func setup() {
        
        courseTextField.delegate = self
        classTextField.delegate = self
        professorTextField.delegate = self
        semesterTextField.delegate = self
        yearTextField.delegate = self
        
        courseTextField.returnKeyType = UIReturnKeyType.Next
        classTextField.returnKeyType = UIReturnKeyType.Next
        professorTextField.returnKeyType = UIReturnKeyType.Next
        semesterTextField.returnKeyType = UIReturnKeyType.Next
        yearTextField.returnKeyType = UIReturnKeyType.Next
        
        courseTextField.tag = 1
        classTextField.tag = 2
        professorTextField.tag = 3
        semesterTextField.tag = 4
        yearTextField.tag = 5
        
        
    }
    
    
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    @IBOutlet weak var uploadStatusLabel: UILabel!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var semesterTextField: UITextField!
    @IBOutlet weak var professorTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var courseTextField: UITextField!
    
    @IBOutlet weak var classTextField: UITextField!
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    //Tells image picker what to do after stuff is chosen,
    //This is needed since the delegate is 'self'
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //If the user presses cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
