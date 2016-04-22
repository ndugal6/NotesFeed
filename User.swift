//
//  User.swift
//  NoteSwap
//
//  Created by Nick Dugal on 3/15/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import Foundation

class Student {
    var name = ""
    var email = ""
    var college = ""
    var courses: Array<Course> = []
  
    
    func addCourse(course: Course) {
        student.courses.append(course)
    }
    //NEED CODE TO DELETE COURSE
    
    func getName() -> String {
        return name
    }
    
    func setName(name: String) {
        student.name = name
    }
    
    func setEmail(email: String) {
        student.email = email
    }
    
    
    func setCollege(college: String) {
        student.college = college
    }
    
//    func getEmail() -> String {
//        if (email != nil)
//        {
//            return email!
//        }
//        return "NA"
//    }
//    
//    func getCollege() -> String {
//        if (college != nil) {
//            return college!
//        }
//        return "NA"
//    }
    
    func getCourses() -> Array<Course> {
            return courses
    }
}
