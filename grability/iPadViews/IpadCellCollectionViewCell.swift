//
//  IpadCellCollectionViewCell.swift
//  grability
//
//  Created by Mario Vizcaino on 21/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit

class IpadCellCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var appImage: UIImageView!
    
    @IBOutlet weak var appTittle: UILabel!
    
    @IBOutlet weak var appPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        //rounder Image View
        appImage.layer.cornerRadius = 15
        appImage.clipsToBounds = true

    }
}
