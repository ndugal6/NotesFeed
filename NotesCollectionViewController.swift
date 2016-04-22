//
//  NotesCollectionViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/17/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
class NotesCollectionViewController: UICollectionViewController {
private let reuseIdentifier = "NoteCell"

    @IBOutlet var resultsCollectionView: UICollectionView!
    
    var classNum: String!
    var semester: String!
    var professor: String!
    var year: String!
    var course: String!
//    var searchString: String = " "
    var resultsArray: NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        self.findNotes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(NotesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func findNotes() {
//        resultsArray.removeAllObjects()
        let findIt: PFQuery = PFQuery(className: courseGlobal)
//        searchString = course
        if (classNum != "") {
            findIt.whereKey("Class", equalTo: classGlobal)
//            searchString += " \(classNum)"
        }
        if (semester != "") {
            findIt.whereKey("Semester", equalTo: semesterGlobal)
//            searchString += " \(semester)"
        }
        if (professor != "") {
            findIt.whereKey("Professor", equalTo: professorGlobal)
//            searchString += " \(professor)"
        }
        if (year != "") {
            findIt.whereKey("Year", equalTo: yearGlobal)
//            searchString += " \(year)"
        }
        
        findIt.findObjectsInBackgroundWithBlock { (objects, error) in
            self.resultsCollectionView.reloadData()
            if (error != nil) {
                print(error?.description)
            }
            else {
                if (objects?.count == 0) {
                    self.resultsCollectionView.hidden = true
                    //self.noResults.hidden = false
                }
                else {
                    for object in objects! {
                        if let objFile = object["Note"] as? PFFile {
                            objFile.getDataInBackgroundWithBlock({ (objData, error2) in
                                self.resultsCollectionView.reloadData()
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
        // self.layoutSetup()
        resultsCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NotesCollectionViewCell
        
        //Configure the Cell
        if (resultsArray.count > 0) {
            let imData = resultsArray[indexPath.row]
            let image = UIImage(data: imData as! NSData)
            cell.imageView.image = image
        }
        return cell
    }
    //Allows adjustment of the pic size inside a collection view
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let imData = resultsArray[indexPath.row]
        let image = UIImage(data: imData as! NSData)
        
        return image!.size
        
    }
    
}

    extension NotesCollectionViewController : UITextFieldDelegate {
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            // 1
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            textField.addSubview(activityIndicator)
            activityIndicator.frame = textField.bounds
            activityIndicator.startAnimating()
            self.findNotes()
            activityIndicator.stopAnimating()
//            print("Found \(resultsArray.count) matching \(searchString)")
            self.resultsCollectionView.reloadData()
            textField.text = nil
            textField.resignFirstResponder()
            return true
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */


