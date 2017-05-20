//
//  DummyAppCollectionViewCell.swift
//  ParallaxEffect
//
//  Created by Tiago Pereira on 20/05/2017.
//  Copyright © 2017 Tiago Pereira. All rights reserved.
//

import UIKit

class DummyAppCollectionViewCell: UICollectionViewCell {
    
    var dummyAppImageView: UIImageView!
    
    override func awakeFromNib() {
        dummyAppImageView = UIImageView(frame: contentView.frame)
        dummyAppImageView.contentMode = .scaleAspectFill
        dummyAppImageView.clipsToBounds = true
        contentView.addSubview(dummyAppImageView)
    }
    
}
