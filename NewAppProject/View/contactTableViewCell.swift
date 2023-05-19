//
//  contactTableViewCell.swift
//  NewAppProject
//
//  Created by NT 2 on 12/04/23.
//

import UIKit

class contactTableViewCell: UITableViewCell {

    @IBOutlet var showbtn: UIButton!
    
    @IBOutlet var timeShowLbl: UILabel!
   
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var namelbl: UILabel!
    @IBOutlet var phoneNoLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        showhidestack.isHidden = true
        profileImage.layer.cornerRadius = profileImage.frame.height/2

    }
    
    
    @IBAction func dialerButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func videoCallButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func expandCellbtn(_ sender: UIButton) {
//        if sender.isSelected == false{
//            sender.isSelected = true
//        }else{
//            sender.isSelected = false
//        }
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
