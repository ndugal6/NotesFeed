//
//  MainTabViewController.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/16/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

var currentUserGlobal = PFUser()
var alreadyCheckedGlobal: Bool = false
class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        currentUserGlobal = PFUser.currentUser()!
        alreadyCheckedGlobal = false
        // Do any additional setup after loading the view.
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

}
