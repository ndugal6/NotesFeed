//
//  Course.swift
//  NoteSwap
//
//  Created by Nick Dugal on 3/15/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import Foundation
import Parse
class Course {
    var course = "NA"
    var classNum = "NA"
    var professor = "NA"
    var year = "NA"
    var semester = "NA"
    var notesData = NSMutableArray()
    var empty = true
    
    init(course: String, classNum: String, professor: String, year: String, semester: String) {
        self.course = course
        if classNum != "" { self.classNum = classNum }
        if professor != "" { self.professor = professor}
        if semester != "" { self.semester = semester}
        if year != "" { self.year = year}
        self.notesData = getNotes()
        self.empty = false
    }
    
    init () { }
    
    init(courseComponents: String) {
        let components = courseComponents.componentsSeparatedByString(".")
        self.course = components[0]
        self.classNum = components[1]
        self.professor = components[2]
        self.semester = components[3]
        self.year = components[4]
        self.notesData = getNotes()
        self.empty = false
        
    }

    func getTitle() -> String {
        var title = self.course
        if classNum != "NA" { title += " " + classNum }
        if professor != "NA"
        {title += " " + professor}
        if semester != "NA"
        { title += " \(semester)" }
        if year != "NA"
        { title += " \(year)" }
        return title
    }
    
    func notes() ->  NSMutableArray {
    return self.notesData
    }
    
    func addToFavorites() {
        var current = PFUser.currentUser()!["favorites"] as! String
        current = current.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "\""))
        PFUser.currentUser()?["favorites"] = "\(current)||\(course).\(classNum).\(professor).\(semester).\(year)"
        PFUser.currentUser()?.saveInBackground()
    }
    
    func getNotes() -> NSMutableArray {
        let resultsArray = NSMutableArray()
        let findIt: PFQuery = PFQuery(className: course)
        //        searchString = course
        if (classNum != "NA") {
            findIt.whereKey("Class", equalTo: classNum)
            //            searchString += " \(classNum)"
        }
        if (semester != "NA") {
            findIt.whereKey("Semester", equalTo: semester)
            //            searchString += " \(semester)"
        }
        if (professor != "NA") {
            findIt.whereKey("Professor", equalTo: professor)
            //            searchString += " \(professor)"
        }
        if (year != "NA") {
            findIt.whereKey("Year", equalTo: year)
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
                        resultsArray.addObject(objData)
                    } catch { }
                }
            }
        }
        catch { }
        return resultsArray
    }
}