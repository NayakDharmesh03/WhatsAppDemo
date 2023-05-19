//
//  SelectedContactsTableViewCell.swift
//  NewAppProject
//
//  Created by NT 2 on 13/04/23.
//

import UIKit

class SelectedContactsTableViewCell: UITableViewCell {

    
     @IBOutlet var profileImage: UIImageView!
     @IBOutlet var namelbl: UILabel!
     @IBOutlet var phoneNoLbl: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.self.layer.cornerRadius = profileImage.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
