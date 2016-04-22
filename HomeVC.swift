//
//  HomeVC.swift
//  NoteSwap
//
//  Created by Nick Dugal on 3/15/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse
var favoritesGlobal: NSMutableArray = NSMutableArray()

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var allCourses = NSMutableArray()
    private let reuseIdentifier = "FavoritesCell"
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
    
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesCollectionView.dataSource = self
        self.favString = "CSC.NA.NA.NA.NA||IE.NA.NA.NA.NA"
        arrayOfFavs = favString.componentsSeparatedByString("||")
        self.courseSetup(arrayOfFavs.count)
        //self.storeNotes()
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
    }
    func courseSetup(amount: Int) -> Void {
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
    func autolayoutSubviews() {
        self.favoritesCollectionView!.topAnchor.constraintEqualToAnchor(self.view.topAnchor).active = true
        self.favoritesCollectionView!.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor).active = true
        self.favoritesCollectionView!.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor).active = true
        self.favoritesCollectionView!.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    }
    
    func setupLayout() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        flowLayout.itemSize = CGSizeMake(145.0, 97.0)
        
        self.favoritesCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.favoritesCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.favoritesCollectionView!.delegate = self
        self.favoritesCollectionView!.dataSource = self
        self.favoritesCollectionView!.registerClass(NotesCollectionViewCell.self, forCellWithReuseIdentifier: "noteCell")
        self.favoritesCollectionView!.registerClass(SectionHeaderView.self, forCellWithReuseIdentifier: "noteCell")
        self.favoritesCollectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.favoritesCollectionView)
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return allCourses.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let theNote = allCourses[section] as! Course
        return theNote.notesData.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NotesCollectionViewCell
        let theCourse: Course = allCourses[indexPath.section] as! Course
        let notesData = theCourse.notesData
        let correctData = notesData.objectAtIndex(indexPath.row)
        let image = UIImage(data: correctData as! NSData)
        cell.imageView.image = image
        
        
//        let queryCriteria = arrayOfFavs[indexPath.section].componentsSeparatedByString(".")
//        courseGlobal = queryCriteria[0]
//        classGlobal = queryCriteria[1]
//        professorGlobal = queryCriteria[2]
//        semesterGlobal = queryCriteria[3]
//        yearGlobal = queryCriteria[4]
//        activityIndicator.startAnimating()
//        findNotes()
//        activityIndicator.stopAnimating()
//        //if (resultsArray.count > 0) {
//        let imData = resultsArray[indexPath.row]
//        let image = UIImage(data: imData as! NSData)
//        cell.imageView.image = image
//        cell.alignmentRectForFrame(CGRect(x: 0, y: 0, width: (UIScreen.mainScreen().bounds.width-20)/2, height: (UIScreen.mainScreen().bounds.height-20)/2))
//        //}
        print("return cell")
        return cell
    }

    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        UIScreen.mainScreen().bounds.width
        return CGSize(width: self.favoritesCollectionView.frame.width, height: self.favoritesCollectionView.frame.height)
        
    }
    
    
    
    func findNotes()
        {
                    resultsArray.removeAllObjects()
            let findIt: PFQuery = PFQuery(className: courseGlobal)
            //        searchString = course
            if (classGlobal != "NA") {
                findIt.whereKey("Class", equalTo: classGlobal)
                //            searchString += " \(classNum)"
            }
            if (semesterGlobal != "NA") {
                findIt.whereKey("Semester", equalTo: semesterGlobal)
                //            searchString += " \(semester)"
            }
            if (professorGlobal != "NA") {
                findIt.whereKey("Professor", equalTo: professorGlobal)
                //            searchString += " \(professor)"
            }
            if (yearGlobal != "NA") {
                findIt.whereKey("Year", equalTo: yearGlobal)
                //            searchString += " \(year)"
            }
            var objects: [PFObject]
            do
            {
                objects = try findIt.findObjects()
                for object in objects
                {
                    if let objFile = object["Note"] as? PFFile
                    {
                        var objData: NSData
                        do
                        { objData = try objFile.getData()
                            self.resultsArray.addObject(objData)
                        } catch { }
                        
                        }
                    }
                
                }
            catch { }
            
    }
}


