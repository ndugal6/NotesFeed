//
//  FavoritesTableViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/19/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse
var allCourses = NSMutableArray()
class FavoritesTableViewController: UIViewController, UITableViewDataSource {
    
    
    var favString = ""
    var arrayOfFavs: [String] = [String]()
    var numberOfFavs = 0
    var resultsArray: NSMutableArray = NSMutableArray()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    var course1 = Course()
    var course2 = Course()
    var course3 = Course()
    var course4 = Course()
    var course5 = Course()
    var course6 = Course()
    
    

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.currentUser())
        self.favString = PFUser.currentUser()!["favorites"] as! String
//        self.favString = "CSC.1351.NA.NA.NA||MATH.2090.NA.Summer.2015||IE.2090.NA.Fall.2014"
        favString = favString.stringByReplacingOccurrencesOfString("\"", withString: "")
        print(favString)
        arrayOfFavs = favString.componentsSeparatedByString("||")
        self.tableView.rowHeight = 350
        
        self.courseSetup(arrayOfFavs.count)
        //self.storeNotes()
        self.activitySetup()
                

    }
    func activitySetup() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    }
    
    func courseSetup(amount: Int) -> Void {
        allCourses.removeAllObjects()
        if amount > 0 {
            course1 = Course(courseComponents: arrayOfFavs[0])
            allCourses.addObject(course1)}
        if amount > 1 { course2 = Course(courseComponents: arrayOfFavs[1])
            allCourses.addObject(course2)}
        if amount > 2 { course3 = Course(courseComponents: arrayOfFavs[2])
            allCourses.addObject(course3)}
        if amount > 3 { course4 = Course(courseComponents: arrayOfFavs[3])
            allCourses.addObject(course4)}
        if amount > 4 { course5 = Course(courseComponents: arrayOfFavs[4])
            allCourses.addObject(course5)}
        if amount > 5 { course6 = Course(courseComponents: arrayOfFavs[5])
            allCourses.addObject(course6)}
    }
    
         // MARK: - Table view data source

    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allCourses.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (allCourses.objectAtIndex(section) as! Course).getTitle()
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! FavoritesTableViewCell

        let course = allCourses.objectAtIndex(indexPath.section) as! Course

        cell.imagesArray = course.notesData
        
        return cell
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //reloadInputViews()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.favString = PFUser.currentUser()!["favorites"] as! String
        favString = favString.stringByReplacingOccurrencesOfString("\"", withString: "")
        arrayOfFavs = favString.componentsSeparatedByString("||")
        self.courseSetup(arrayOfFavs.count)
        self.tableView.reloadData()
    }
  
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
