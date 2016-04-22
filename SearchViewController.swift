//
//  SearchViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/14/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse
var yearGlobal: String!
var semesterGlobal: String!
var professorGlobal: String!
var courseGlobal: String!
var classGlobal:String!

private let reuseIdentifier = "NoteCell"


class SearchViewController: UIViewController,UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
var resultsArray: NSMutableArray = NSMutableArray()

    var searchCourse = Course()
   
    @IBOutlet weak var addToFavsButton: UIButton!
    @IBAction func addToFavs(sender: UIButton) {
        searchCourse = Course(course: self.courseTextField.text!, classNum: self.classTextField.text!, professor: self.professorTextField.text!, year: self.yearTextField.text!, semester: semesterTextField.text!)
        //addToFavsButton.hidden = true
        success.hidden = false
        searchCourse.addToFavorites()
        addToFavsButton.setAttributedTitle(NSAttributedString(string: "Success"), forState: UIControlState.Normal)
        

        
    
    }
    
    @IBOutlet weak var success: UIButton!
    
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        
        
        
    }
    
    
    @IBOutlet weak var notesCollectionView: UICollectionView!
    //@IBOutlet weak var resultsCollectionView: UICollectionView!

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var semesterTextField: UITextField!
    @IBOutlet weak var professorTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var courseTextField: UITextField!
    
    let noResults: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40)) as UILabel
  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addToFavsButton.hidden = true
        
        self.setup()
        //self.layoutSetup()
        //self.resultsCollectionView?.registerClass(NotesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        //let tap = UITapGestureRecognizer(target: self, action: "showMoreActions:")
        //tap.numberOfTapsRequired = 1
        //view.addGestureRecognizer(tap)


        // Configures the Base case of no results
        noResults.hidden = true
        noResults.text = "No Results Found"
        noResults.center = self.view.center
        noResults.updateConstraints()
        noResults.textAlignment = NSTextAlignment.Center
        noResults.textColor = UIColor.redColor()
        noResults.backgroundColor = UIColor.lightGrayColor()
        resultsArray.removeAllObjects()
        
        
        

        // Do any additional setup after loading the view.
    }
    
//    func layoutSetup() {
//        let myLayout = MyFlowLayout()
//        self.resultsCollectionView?.setCollectionViewLayout(myLayout, animated: true)
//        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(SearchViewController.handlePinch(_:)))
//        self.resultsCollectionView?.addGestureRecognizer(pinchRecognizer)
//    }

/*
//Mark - TextField setup
//
*/
    //Arbitraty method name
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
    
 
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch (textField) {
        case courseTextField:
            classTextField.becomeFirstResponder()
        case classTextField:
            professorTextField.becomeFirstResponder()
        case professorTextField:
            semesterTextField.becomeFirstResponder()
        case semesterTextField:
            yearTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func findNotes() {
        
        
                resultsArray.removeAllObjects()
        let findIt: PFQuery = PFQuery(className: courseTextField.text!)
        if (classTextField.text! != "") {
            findIt.whereKey("Class", equalTo: classTextField.text!)
        }
        if (semesterTextField.text! != "") {
            findIt.whereKey("Semester", equalTo: semesterTextField.text!)
        }
        if (professorTextField.text! != "") {
            findIt.whereKey("Professor", equalTo: professorTextField.text!)
        }
        if (yearTextField.text! != "") {
            findIt.whereKey("Year", equalTo: yearTextField.text!)
        }
        
        findIt.findObjectsInBackgroundWithBlock { (objects, error) in
            self.notesCollectionView.reloadData()
            if (error != nil) {
                print(error?.description)
            }
            else {
                if (objects?.count == 0) {
                    self.notesCollectionView.hidden = true
                }
                else {
                    for object in objects! {
                        if let objFile = object["Note"] as? PFFile {
                            objFile.getDataInBackgroundWithBlock({ (objData, error2) in
                                self.notesCollectionView.reloadData()
                                if (error == nil) {
                                    self.resultsArray.addObject(objData!)
                                } else {
                                    print(error2?.description)
                                }
                            })
                        }
                    }
                }
            }
        }
        notesCollectionView.reloadData()
        addToFavsButton.hidden = false
    }
    
  
    
    @IBAction func searchButtonTapped(sender: UIButton) {
    
    
        self.findNotes()
        classGlobal = self.classTextField.text!
        courseGlobal = self.courseTextField.text!
        semesterGlobal = self.semesterTextField.text!
        professorGlobal = self.professorTextField.text!
        yearGlobal = self.yearTextField.text!
        self.dismissKeyboard()
        //performSegueWithIdentifier("ShowNotesShortcut", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  
        if segue.identifier == "ShowNotesShortcut" {
            let upcoming: NotesCollectionViewController = segue.destinationViewController as! NotesCollectionViewController
            
            upcoming.classNum = self.classTextField.text!
            upcoming.course = self.courseTextField.text!
            upcoming.semester = self.semesterTextField.text!
            upcoming.professor = self.professorTextField.text!
            upcoming.year = self.yearTextField.text!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //MARK: CollectionView
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NotesCollectionViewCell
        
        //Configure the Cell
        if (resultsArray.count > 0) {
        let imData = resultsArray[indexPath.row]
        let image = UIImage(data: imData as! NSData)
        cell.imageView.image = image
            }
        return cell
    }
    
    // MARK: UICollectionViewFlowLayoutDelegate
    
    
    
    func collectionView(colectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let myLayout = UICollectionViewFlowLayout()
        
        myLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        //self.resultsCollectionView.setCollectionViewLayout(myLayout, animated: true)
    }
    
    //Allows adjustment of the pic size inside a collection view
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSize(width: self.notesCollectionView.frame.width, height: self.notesCollectionView.frame.height)
        
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

//Allows keyboard to be dismissed on any VC by calling "self.hideKeyboardWhenTappedAround()" in viewDidLoad()
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
//Calls this function when tap is recognized
    func dismissKeyboard() {
//Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
