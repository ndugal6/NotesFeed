//
//  MyFlowLayout.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/17/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit


protocol PinterestLayoutDelegate {
    // 1
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    // 2
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

//CLASS TO ADD FUNCTIONALITY TO CELLS IN COLLECTION VIEW. PROPERTIES(INITIAL ONES) ARE TO STORE INFO ON CELL BEING MANIPULATED, SCALE VALUE FOR RESIZE, AND CUR LOC OF CELL
class MyFlowLayout: UICollectionViewFlowLayout {
    
    var currentCellPath: NSIndexPath?
    var currentCellCenter: CGPoint?
    var currentCellScale: CGFloat?
    
    
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    

    
    
    
    
    
    
    func setCurrentCellScale(scale: CGFloat) {
        currentCellScale = scale
        self.invalidateLayout()
        
    }
    func setCurrentCellCenter(origin: CGPoint) {
        currentCellCenter = origin
        self.invalidateLayout()
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        //Allows class to know what attributes are normally in order to customize them
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        self.modifyLayoutAttributes(attributes!)
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAtttributesInRect = super.layoutAttributesForElementsInRect(rect)
        
        for cellAttributes in allAtttributesInRect! {
            self.modifyLayoutAttributes(cellAttributes )
        }
        return allAtttributesInRect!
    }
    
    //This is where the layout attributes for the cell the user is currently manipulating on the screen are modified.
    func modifyLayoutAttributes(layoutattributes:
        UICollectionViewLayoutAttributes) {
        
        if layoutattributes.indexPath == currentCellPath {
            layoutattributes.transform3D =
                CATransform3DMakeScale(currentCellScale!,
                                       currentCellScale!, 1.0)
            layoutattributes.center = currentCellCenter!
            layoutattributes.zIndex = 1
        }
    }
    
}
