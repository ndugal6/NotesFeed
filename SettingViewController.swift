//
//  SettingViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 3/15/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

class SettingViewController: UIViewController {
    @IBOutlet weak var class1: UILabel!

    @IBOutlet weak var class2: UILabel!
    @IBOutlet weak var class3: UILabel!
    @IBOutlet weak var class4: UILabel!
    @IBOutlet weak var class5: UILabel!
    @IBOutlet weak var class6: UILabel!
    @IBOutlet weak var x1: UIButton!
    @IBOutlet weak var x2: UIButton!
    @IBOutlet weak var x3: UIButton!
    @IBOutlet weak var x4: UIButton!
    @IBOutlet weak var x5: UIButton!
    @IBOutlet weak var x6: UIButton!
    @IBAction func deleteFavorite(sender: UIButton) {
        var favString = PFUser.currentUser()?["favorites"] as! String
        favString = favString.stringByReplacingOccurrencesOfString("\"", withString: "")
        var favArray = favString.componentsSeparatedByString("||")
        var killFav = 0
        if sender == x1 { killFav = 0; class1.hidden = true; x1.hidden = true }
        if sender == x2 { killFav = 1; class2.hidden = true; x2.hidden = true }
        if sender == x3 { killFav = 2; class3.hidden = true; x3.hidden = true }
        if sender == x4 { killFav = 3; class4.hidden = true; x4.hidden = true }
        if sender == x5 { killFav = 4; class5.hidden = true; x5.hidden = true }
        if sender == x6 { killFav = 5; class6.hidden = true; x6.hidden = true }
        favArray.removeAtIndex(killFav)
        for favs in favArray {
            favString = "\(favs)||"
        }
        favString = favString.substringToIndex(favString.endIndex.predecessor().predecessor())
        print(favString)
        PFUser.currentUser()?["favorites"] = favString
        PFUser.currentUser()?.saveInBackground()
        self.setup()
    }
    
    
    
    @IBAction func logoutFunction(sender: UIButton) {
        
        PFUser.logOut()
        performSegueWithIdentifier("logoutSegue", sender: self)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setup() {
        if allCourses.count > 0 { class1.text = (allCourses.objectAtIndex(0) as! Course).getTitle()
            class1.hidden = false; x1.hidden = false }
        if allCourses.count > 1 { class2.text = (allCourses.objectAtIndex(1) as! Course).getTitle()
            class2.hidden = false; x2.hidden = false}
        if allCourses.count > 2 { class3.text = (allCourses.objectAtIndex(2) as! Course).getTitle()
            class3.hidden = false; x3.hidden = false}
        if allCourses.count > 3 { class4.text = (allCourses.objectAtIndex(3) as! Course).getTitle()
            class4.hidden = false; x4.hidden = false}
        if allCourses.count > 4 { class5.text = (allCourses.objectAtIndex(4) as! Course).getTitle()
            class5.hidden = false; x5.hidden = false}
        if allCourses.count > 5 { class6.text = (allCourses.objectAtIndex(5) as! Course).getTitle()
            class6.hidden = false; x6.hidden = false}
        
    }
}
