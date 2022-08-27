//
//  TableViewCell.swift
//  NatiaL_HW26
//
//  Created by Natia's Mac on 27.08.22.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {
    @IBOutlet weak var textlb: UILabel!
    @IBOutlet weak var makeFavBtn: UIButton!
    
    var coreData: CoreDataManager!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func makeFavNote(_ sender: UIButton) {
        coreData = CoreDataManager()
        guard let currentNote = self.textlb.text else { return }
       
        if sender.isSelected {
            sender.tintColor = .yellow
            coreData.isFavorite(the: currentNote, value: true)
        } else {
            sender.tintColor = .tintColor
            coreData.isFavorite(the: currentNote, value: false)
        }
        
    }
    

}
