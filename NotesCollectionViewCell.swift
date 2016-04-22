//
//  NotesCollectionViewCell.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/16/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        self.imageView.drawRect(self.frame)
    }
    
}
