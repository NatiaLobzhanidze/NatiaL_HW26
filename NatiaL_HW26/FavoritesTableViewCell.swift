//
//  FavoritesTableViewCell.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var textLb: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func uncheckedFavs(_ sender: UIButton) {
        
    }
}
