//
//  iPhoneTableViewCell.swift
//  grability
//
//  Created by Mario Vizcaino on 21/02/17.
//  Copyright © 2017 Mario Vizcaino. All rights reserved.
//

import UIKit

class iPhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let heigthCell:CGFloat = 80.0;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        //Rounded image View
        appImageView.layer.cornerRadius = 15
        appImageView.clipsToBounds = true
        
    }

}
