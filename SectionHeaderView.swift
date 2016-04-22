//
//  SectionHeaderView.swift
//  NoteSwap
//
//  Created by Nick Dugal on 4/19/16.
//  Copyright © 2016 Nick Dugal. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    var titleLabel: UILabel?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    func setupSubviews() {
        self.titleLabel = UILabel()
        self.titleLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel!.font = UIFont.systemFontOfSize(24.0)
        self.addSubview(self.titleLabel!)
    }
    func autolayoutSubviews() {
        self.titleLabel!.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10.0).active = true
        self.titleLabel!.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -10.0).active = true
        self.titleLabel!.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 10.0).active = true
        self.titleLabel!.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -10.0).active = true
    }
}
