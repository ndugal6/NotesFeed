//
//  FavoritesTableViewCell.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/19/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit
import Parse

class FavoritesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var rowCollectionView: UICollectionView!
    
    var imagesArray = NSMutableArray()
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.rowCollectionView.frame.height, height: self.rowCollectionView.frame.height)
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favNoteCell", forIndexPath: indexPath) as! NotesCollectionViewCell
        cell.imageView.image = UIImage(data: imagesArray.objectAtIndex(indexPath.row) as! NSData )
        cell.imageView.drawRect(self.frame)
        cell.setNeedsDisplay()
        return cell
    }
    

}


